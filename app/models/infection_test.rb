# == Schema Information
#
# Table name: infection_tests
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  infection_id :integer
#  visit_id     :integer
#  uuid         :uuid
#  created_at   :datetime
#  updated_at   :datetime
#

class InfectionTest < ActiveRecord::Base
  include EnsureUuid

  belongs_to :infection
  belongs_to :visit

  validates :name, presence: true
  validates :infection_id, presence: true
  validates :visit_id, presence: true

  has_paper_trail
end
