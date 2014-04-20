require 'csv'

class DataStreamImporter
  include Contracts
  include ActiveModel::Model

  attr_accessor :stream

  Contract nil => ArrayOf[ArrayOf[Or[String,Num,nil]]]
  def rows
    @rows ||= CSV.parse(stream)
    header
    @rows
  end

  Contract nil => Maybe[ArrayOf[Symbol]]
  def header
    @header ||= @rows.shift.map(&:to_sym) if @rows
  end

  Contract nil => ArrayOf[HashOf[Symbol, Or[String,Num,nil]]]
  def to_hashes
    output = rows.map do |row|
      Hash[header.zip(row)]
    end

    output
  end
end
