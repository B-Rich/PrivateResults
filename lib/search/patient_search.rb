class PatientSearch
  include ActiveModel::Model

  attr_accessor :patient_number

  validates :patient_number, presence: true

  def patients
    @patients ||= Patient.where(patient_number: patient_number)
  end
end
