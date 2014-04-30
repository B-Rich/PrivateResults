require 'csv'

# Imports CSV data from an IO stream by converting to hashes
# @api public
class DataStreamImporter
  include Contracts
  include ActiveModel::Model

  attr_accessor :stream

  Contract nil => ArrayOf[ArrayOf[Or[String,Num,nil]]]
  # Loads CSV data from the IO stream using the CSV stdlib
  # @api private
  # @return [Array<Array<String,Num,nil>>] parsed CSV rows
  def rows
    unless @rows.present?
      Rails.logger.info("Parsing #{stream.size} bytes of CSV stream")
      @rows ||= CSV.parse(stream.read)
      header
    end

    @rows
  end

  Contract nil => ArrayOf[Symbol]
  # Returns the header row as an array of symbols
  # @api private
  # @return [Array<Symbol>] the header row
  def header
    @header ||= rows.shift.map(&:to_sym) if rows
  end

  Contract nil => ArrayOf[HashOf[Symbol, Or[String,Num,nil]]]
  # Provides CSV rows as hashes with column headers as keys
  # @api public
  # @example
  #  data_stream_importer.to_hashes
  # @return [Array<Hash{Symbol => String,Num,nil}>] CSV rows as hashes
  def to_hashes
    output = rows.map do |row|
      Hash[header.zip(row)]
    end

    output
  end
end
