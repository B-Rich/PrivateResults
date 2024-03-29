module Insight
  # Orchestration of entire Insight CSV import process
  class CsvImporter
    include Contracts
    include ActiveModel::Model

    # @api private
    # @!attribute [rw] stream
    # @return [IO] the IO stream from which data comes
    attr_accessor :stream

    # Produces row data as hashes
    # @api private
    # @return [Array<Hash>]
    def row_hashes
      @row_hashes ||= DataStreamImporter.new(stream: stream).to_hashes
    end

    # Execute Insight CSV import
    # @api public
    # @example
    #  csv_importer.import!
    # @return [Array<Patient>] constructed Patient models
    def import!
      Rails.logger.info("Processing rows")

      row_hashes.map do |row_hash|
        Insight::RowHandler.new(row_hash: row_hash).run!
      end
    end
  end
end
