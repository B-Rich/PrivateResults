class Visit < ActiveRecord::Base
  belongs_to :patient

  validates :partners_last_6_months_5_or_more, numericality: true
  validates :visited_on, presence: true
  validates :cosite, presence: true
  validates :age, numericality: true
  validates :uuid, presence: true, uniqueness: true
end
