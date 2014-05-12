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
    @results ||= Result
               .where(visit_id: visits.pluck(:id))
               .select(:visit_id, :id, :positive)
               .includes(:visit)
  end

  # Results for a given date
  # @api private
  # @param date [Date] the date in question
  # @return [ActiveRecord::AssociationRelation<Result>]
  def results_for_date(date)
    results_by_date.fetch(date, [])
  end

  def results_by_date
    @results_by_date ||= results.group_by {|result| result.visit.visited_on }
  end
  # Visits for the infection during the given timeframe
  # @api private
  # @return [ActiveRecord::AssociationRelation<Visit>]
  def visits
    @visits ||= Visit
              .joins(:infection_tests, :results)
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
    result_statuses = results_for_date(date).map(&:positive)
    {
      :total    => result_statuses.count,
      :positive => result_statuses.select(&:present?).count,
      :negative => result_statuses.reject(&:present?).count
    }
  end

  # Infection tests for the infection during the given timeframe
  #
  # @api private
  # @return [ActiveRecord::AssociationRelation<InfectionTest>]
  def infection_tests
    @infection_tests ||= InfectionTest.where(id: results.pluck(:infection_test_id))
  end


  def infection_tests_by_date
    @infection_tests_by_date ||= infection_tests.includes(:visit).group_by {|infection_test| infection_test.visit.visited_on }
  end
  # Infection tests for the infection on the given date
  #
  # @api private
  # @param date [Date] the date in question
  # @return [ActiveRecord::AssociationRelation<InfectionTest>]
  def infection_tests_for_date(date)
    #infection_tests.joins(:visit).where(Visit.arel_table[:visited_on].eq date)
    infection_tests_by_date.fetch(date, [])
  end

  # Constructs an infection activity hash for a given date
  # @api private
  # @param date [Date] the date in question
  # @return [Hash{Symbol => Fixnum,Hash}] breakdown hash
  def infection_activity_hash_for_date(date)
    {
      :date    => date,
      :total   => infection_tests_for_date(date).map(&:id).count,
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
