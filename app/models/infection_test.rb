class InfectionTest < ActiveRecord::Base
  include EnsureUuid

  belongs_to :infection
  belongs_to :visit

  validates :name, presence: true
  validates :infection_id, presence: true
  validates :visit_id, presence: true

  has_paper_trail
end
