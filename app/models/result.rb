class Result < ActiveRecord::Base
  include EnsureUuid

  belongs_to :infection_test

  validates :name, presence: true
  validates :infection_test_id, presence: true

  has_paper_trail
end
