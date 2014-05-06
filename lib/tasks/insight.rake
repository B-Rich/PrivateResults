require 'weakref'

namespace :insight do
  CSV_FILENAME = ENV['CSV']
  REDIS_KEY = "CSV_JSON_ROW_QUEUE"

  desc "import file given in CSV"
  task :import => :environment do
    Rails.logger.tagged("INSIGHT_CSV_IMPORT") do
      if File.exists?(CSV_FILENAME)
        Rails.logger.info("Beginning import process for #{CSV_FILENAME} with size #{File.size(CSV_FILENAME)}")

        File.open(CSV_FILENAME, 'rb') do |file|
          Insight::CsvImporter.new(stream: file).import!
        end

        Rails.logger.info("Finished import of #{CSV_FILENAME}")
      else
        Rails.logger.fatal("Given a CSV file which doesn't exist: #{CSV_FILENAME}")
      end
    end
  end

  desc "Load CSV rows into redis"
  task :load_in_redis => :environment do
    Rails.logger.tagged("DIVIDE_INSIGHT_CSV") do
      if File.exists?(CSV_FILENAME)
        Rails.logger.info("Beginning loading of #{CSV_FILENAME} into redis #{REDIS_KEY}")

        File.open(CSV_FILENAME, 'rb') do |file|
          row_hashes = DataStreamImporter.new(stream: file).to_hashes

          Rails.logger.info("Queueing individual row hashes")
          row_hashes.each do |row_hash|
            Oj.dump(row_hash).tap do |json|
              Rails.logger.info("Enqueuing #{json.length} bytes of JSON")
              REDIS.lpush(REDIS_KEY, json)
            end
          end
        end

        Rails.logger.info("Finished loading of #{CSV_FILENAME}")
      else
        Rails.logger.fatal("Given a CSV file which doesn't exist: #{CSV_FILENAME}")
      end
    end
  end

  desc "Import data from redis queue"
  task :import_from_redis => :environment do
    Signal.trap('INT') do
      exit!
      Rails.logger.info("Got SIGINT! Exiting...")
    end

    Rails.logger.tagged("INSIGHT_IMPORT_WORKER #{Process.pid}") do
      Rails.logger.info("Beginning import from redis queue")
      while REDIS.llen(REDIS_KEY) > 0
        REDIS.lpop(REDIS_KEY).tap do |raw_json|
          begin
            if raw_json.blank?
              Rails.logger.warn("Skipping blank value from queue")
            else
              Rails.logger.info("Got #{Rainbow(raw_json.length.to_s).blue} byes of JSON from queue")
              row_hash = Oj.load(raw_json)

              WeakRef.new(Insight::RowHandler.new(row_hash: row_hash)).run!
            end

          rescue Exception => e
            Rails.logger.warn("Unable to persist row! Re-adding to queue! #{Rainbow(e.backtrace.join("\n")).red}")
            REDIS.rpush(REDIS_KEY, raw_json)
          end
        end
      end
      Rails.logger.info("Finished importing from redis. Exiting")
    end
  end
end
