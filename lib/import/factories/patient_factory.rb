class PatientFactory
  include Contracts
  include ActiveModel::Model

  attr_accessor :patient_number

  Contract nil => Patient
  def make!
    Patient
      .where(patient_number: patient_number)
      .first_or_create!
  end
end
