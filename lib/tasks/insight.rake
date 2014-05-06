namespace :insight do
  desc "import file given in CSV"
  task :import => :environment do
    Rails.logger.tagged("INSIGHT_IMPORT") do
      filename = ENV['CSV']
      if File.exists?(filename)
        Rails.logger.info("Beginning import process for #{filename} with size #{File.size(filename)}")

        File.open(filename, 'rb') do |file|
          Insight::CsvImporter.new(stream: file).import!
        end

        Rails.logger.info("Finished import of #{filename}")
      else
        Rails.logger.fatal("Given a CSV file which doesn't exist: #{filename}")
      end
    end
  end
end
