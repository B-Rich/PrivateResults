# Generates {Infection} trends based on positive {Result} records
class InfectionTrendSummarizer
  include ActiveModel::Model
  include Contracts

  attr_accessor :from, :to, :infections

  # Interval in days
  # @return [Fixnum] the numeric interval
  INTERVAL = 14

  Contract nil => Hash
  # Returns a hash of {Infection} trends
  # @api public
  # @return [Hash{String => Array<Fixnum>}]
  def infection_trends
    Rails.logger.info("Generating #{Infection.model_name.human} trends for: #{infections.map(&:name).join(', ')}")
    infections.each_with_object({}) do |infection, hash|
      hash[infection.name] = infection_counts(infection)
    end
  end

  Contract Infection => Hash
  # Computes positive counts for the given {Infection}
  # @api private
  # @return [Hash{Date => Fixnum}] The date/value hash
  def infection_counts(infection)
    Rails.logger.info("Calculating trends for #{Infection.model_name.human} #{infection.name} from #{from} -- #{to}")
    (from.to_date..to.to_date).step(INTERVAL).each_with_object({}) do |date, hash|
      range = infection_counts_range(date, INTERVAL)

      hash[date] = infection_count(infection, range)
    end
  end

  Contract Infection, Range => Num
  # Computes {Infection} count
  #
  # @api private
  # @param infection [Infection] the infection for which to calculate counts
  # @param range [Range] the range for query
  # @return [Fixnum] the computed count (gteq 0)
  def infection_count(infection, range)
    infection.results
      .positive
      .joins(:visit)
      .where(Visit.arel_table[:visited_on].in range)
      .count
  end

  Contract Date, Num => Range
  # Generates Range for {Infection} count query
  #
  # @api private
  # @param date [Date] the date from which to calculate the interval
  # @param interval [Fixnum] the interval for calculation
  # @return [Range] the calculated range
  def infection_counts_range(date, interval)
    date..(date + (INTERVAL - 1).days).to_date
  end
end
