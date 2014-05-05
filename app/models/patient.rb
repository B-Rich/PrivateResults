# == Schema Information
#
# Table name: patients
#
#  id             :integer          not null, primary key
#  patient_number :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  uuid           :uuid
#

class Patient < ActiveRecord::Base
  include EnsureUuid

  validates :patient_number, presence: true, uniqueness: true

  has_many :visits, dependent: :destroy
  has_paper_trail
end
