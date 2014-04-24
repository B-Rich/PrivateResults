class Patient < ActiveRecord::Base
  validates :patient_number, presence: true, uniqueness: true
  validates :uuid, presence: true, uniqueness: true

  has_many :visits
end
