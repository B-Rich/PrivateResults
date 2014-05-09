# Summarizes all activities for a given {Infection} in a time period
#
# @api public
class InfectionActivitySummarizer
  include Contracts
  include ActiveModel::Model

  attr_accessor :infection, :from, :to

  JSON_SCHEMA = {
    "$schema" => "http://json-schema.org/draft-04/schema#",
    :type       => "object",
    :required   => %W{date total results},
    :properties => {
      :total    => { type: 'integer' },
      :name     => { type: 'string' },
      :results  => {
        :type       => 'object',
        :required   => %W{ positive negative total },
        :properties => {
          :positive => { type: 'integer' },
          :negative => { type: 'integer' },
          :total    => { type: 'integer' }
        }
      }
    }
  }

  # Gets results for the given infection within the provided time frame
  # @api private
  # @return [ActiveRecord::AssociationRelation<Result>]
  def results
    @results ||= infection
               .results
               .joins(:infection_test => :visit)
               .where(Visit.arel_table[:visited_on].in (from..to))
  end

  # Results for a given date
  # @api private
  # @param date [Date] the date in question
  # @return [ActiveRecord::AssociationRelation<Result>]
  def results_for_date(date)
    results.where(Visit.arel_table[:visited_on].eq date)
  end

  # Visits for the infection during the given timeframe
  # @api private
  # @return [ActiveRecord::AssociationRelation<Visit>]
  def visits
    @visits ||= Visit
              .joins(:infection_tests => :results)
              .where(visited_on: (from..to))
              .where(InfectionTest.arel_table[:infection_id].eq infection.id)
              .distinct
  end

  # Constructs a positive/negative/total result breakdown hash for a
  # given date
  #
  # @api private
  # @param date [Date] the date in question
  # @return [Hash<Symbol,Fixnum>] breakdown hash
  def result_breakdown_hash_for_date(date)
    {
      :total    => results_for_date(date).count,
      :positive => results_for_date(date).positive.count,
      :negative => results_for_date(date).negative.count
    }
  end

  # Infection tests for the infection during the given timeframe
  #
  # @api private
  # @return [ActiveRecord::AssociationRelation<InfectionTest>]
  def infection_tests
    InfectionTest.where(id: results.pluck(:infection_test_id))
  end

  # Infection tests for the infection on the given date
  #
  # @api private
  # @param date [Date] the date in question
  # @return [ActiveRecord::AssociationRelation<InfectionTest>]
  def infection_tests_for_date(date)
    infection_tests.joins(:visit).where(Visit.arel_table[:visited_on].eq date)
  end

  # Constructs an infection activity hash for a given date
  # @api private
  # @param date [Date] the date in question
  # @return [Hash{Symbol => Fixnum,Hash}] breakdown hash
  def infection_activity_hash_for_date(date)
    {
      :date    => date,
      :total   => infection_tests_for_date(date).count,
      :results => result_breakdown_hash_for_date(date)
    }
  end

  # Override of as_json
  # @api public
  # @example
  #  infection_activity_summarizer.as_json
  # @return [Hash] the ready-to-serialize hash
  def as_json(options = {})
    {
      :infection => infection.name,
      :data      => visits.pluck(:visited_on).map {|date| infection_activity_hash_for_date(date) }
    }
  end
end
