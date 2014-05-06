namespace :insight do
  CSV_FILENAME = ENV['CSV']
  REDIS_KEY = "CSV_JSON_ROW_QUEUE"

  desc "import file given in CSV"
  task :import => :environment do
    Rails.logger.tagged("INSIGHT_IMPORT") do
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

  desc "Load CSV hashes into redis"
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
end
