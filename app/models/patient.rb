class Patient < ActiveRecord::Base
  validates :patient_number, presence: true, uniqueness: true
end
