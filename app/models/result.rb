# == Schema Information
#
# Table name: results
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  infection_test_id :integer
#  uuid              :uuid
#  positive          :boolean          default(TRUE), not null
#  created_at        :datetime
#  updated_at        :datetime
#  visit_id          :integer
#  infection_id      :integer
#

class Result < ActiveRecord::Base
  include EnsureUuid

  belongs_to :infection_test
  belongs_to :infection
  belongs_to :visit

  validates :name, presence: true
  validates :infection_test_id, presence: true
  validates :infection_id, presence: true
  validates :visit_id, presence: true

  scope :positive, -> { where(positive: true) }
  scope :negative, -> { where.not(positive: true) }

  has_paper_trail
end
