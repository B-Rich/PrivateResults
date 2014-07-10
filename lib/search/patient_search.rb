class PatientSearch
  include ActiveModel::Model

  attr_accessor :patient_number

  validates :patient_number, presence: true
end
