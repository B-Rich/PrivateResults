# Generates {Patient} model from supplied data. Idempotent.
# @api public
class PatientFactory
  include Contracts
  include ActiveModel::Model

  attr_accessor :patient_number

  Contract nil => Patient
  # Constructs model
  # @api public
  # @example
  #  patient_factory.make!
  # @return [Patient] the created patient
  def make!
    Rails.logger.tagged("PatientFactory") do
      Patient
        .where(patient_number: patient_number)
        .first_or_create!
    end
  end
end
