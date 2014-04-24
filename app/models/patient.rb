class Patient < ActiveRecord::Base
  include EnsureUuid

  validates :patient_number, presence: true, uniqueness: true

  has_many :visits
end
