# Generates {InfectionTest} model from supplied data. Idempotent.
# @api public
class InfectionTestFactory
  include Contracts
  include ActiveModel::Model

  attr_accessor :name, :visit_id, :infection_id

  Contract nil => InfectionTest
  # Constructs model
  # @api public
  # @return [InfectionTest] the created visit
  def make!
    InfectionTest
      .where(:name => name,
             :visit_id => visit_id,
             :infection_id => infection_id)
      .first_or_create!
  end
end
