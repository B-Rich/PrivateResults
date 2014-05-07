# == Schema Information
#
# Table name: infections
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  uuid       :uuid
#  created_at :datetime
#  updated_at :datetime
#

class Infection < ActiveRecord::Base
  include EnsureUuid

  validates :name, presence: true, uniqueness: true

  has_many :infection_tests
  has_many :results, through: :infection_tests

  has_paper_trail
end
