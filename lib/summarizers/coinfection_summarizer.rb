# Generates coinfection summary for a given {Infection}
class CoinfectionSummarizer
  include Contracts
  include ActiveModel::Model

  attr_accessor :infection

  Contract nil => Hash
  # Master table of all coinfections for every {Infection}
  # @api public
  # @return [Hash<String,Hash<String,Fixnum>>] table of all coinfection hashes
  def self.coinfection_table
    Infection.all.each_with_object({}) do |infection, hash|
      hash[infection.name] = new(infection: infection).coinfection_hash
    end
  end

  Contract nil => Hash
  # Gives the coinfection rate for the provided {Infection} as a Hash
  #
  # @api public
  # @example
  #  coinfection_summarizer.coinfection_hash
  # @return [Hash{String=>Fixnum}] Hash with coinfection rates
  def coinfection_hash
    infections.map do |potential_coinfection|
      count = base_query
              .where(id: infected_patient_ids)
              .where(Result.arel_table[:infection_id].eq potential_coinfection.id)
              .count

      { potential_coinfection.name => count }
    end.reduce(&:merge)
  end

  # All {Infection} records
  # @api private
  # @return [Array<Infection>] All present infections
  def infections
    @infections ||= Infection.all
  end

  Contract nil => ArrayOf[Num]
  # The ids of {Patient} records infected with the master {Infection}
  # @api private
  # @return [Array<Fixnum>] all infected patient ids (unique)
  def infected_patient_ids
    @infected_patient_ids ||= base_query
                            .where(Result.arel_table[:infection_id].eq infection.id)
                            .pluck(:id)
  end

  # @api private
  def base_query
    Patient
      .distinct
      .joins(:visits => {:infection_tests => :result})
      .where(Result.arel_table[:positive].eq true)
      .distinct
  end
end
