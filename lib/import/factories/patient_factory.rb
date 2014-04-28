# Generates {Patient} model from supplied data. Idempotent.
# @api public
class PatientFactory
  include Contracts
  include ActiveModel::Model

  attr_accessor :patient_number

  Contract nil => Patient
  # Constructs model
  # @api public
  # @return [Patient] the created patient
  def make!
    Patient
      .where(patient_number: patient_number)
      .first_or_create!
  end
end
