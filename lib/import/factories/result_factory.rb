# Generates {Result} model from supplied data. Idempotent.
# @api public
class ResultFactory
  include ActiveModel::Model
  include Contracts

  attr_accessor :name, :infection_test_id, :positive, :infection_id, :visit_id

  Contract nil => Result
  # Constructs model
  # @api public
  # @example
  #  result_factory.make!
  # @return [Result] the created result
  def make!
    Rails.logger.tagged("ResultFactory") do
      Result
        .where(:name => name,
               :infection_test_id => infection_test_id,
               :positive => positive,
               :visit_id => visit_id,
               :infection_id => infection_id)
        .first_or_create!
    end
  end
end
