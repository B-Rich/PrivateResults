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

  has_paper_trail
end
