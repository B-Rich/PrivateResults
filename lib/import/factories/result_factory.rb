# Generates {Result} model from supplied data. Idempotent.
# @api public
class ResultFactory
  include ActiveModel::Model
  include Contracts

  attr_accessor :name, :infection_test_id, :positive

  Contract nil => Result
  # Constructs model
  # @api public
  # @return [Result] the created result
  def make!
    Result
      .where(:name => name,
             :infection_test_id => infection_test_id,
             :positive => positive)
      .first_or_create!
  end
end
