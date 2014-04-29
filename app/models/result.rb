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
#

class Result < ActiveRecord::Base
  include EnsureUuid

  belongs_to :infection_test

  validates :name, presence: true
  validates :infection_test_id, presence: true

  has_paper_trail
end
