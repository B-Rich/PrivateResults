# Orchestration of entire Insight CSV import process
module Insight
  class CsvImporter
    include Contracts
    include ActiveModel::Model

    attr_accessor :stream

    # Execute Insight CSV import
    # @api public
    # @return [Array<Patient>] constructed Patient models
    def import!
      row_hashes = DataStreamImporter.new(stream: stream).to_hashes
      Rails.logger.info("Read #{row_hashes.count} rows from stream")

      Rails.logger.info("Processing rows")
      row_hashes.map do |row_hash|
        Insight::RowHandler.new(row_hash: row_hash).run!
      end
    end
  end
end
