class Infection < ActiveRecord::Base
  include EnsureUuid

  validates :name, presence: true, uniqueness: true

  has_paper_trail
end
