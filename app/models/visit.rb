class Visit < ActiveRecord::Base
  belongs_to :patient

  COSITE_VALUES = %W{C D E SJ TB U}
  SEX_VALUES = %W{M F T ?}
  RACE_VALUES = [
    'American Indian/Alaska Native',
    'Asian',
    'Asian/Pacific Islands',
    'Black/African American',
    'Hispanic',
    'Native Hawaiian/Pacific Island',
    'Other',
    'White'
  ]

  validates :partners_last_6_months_5_or_more, numericality: true
  validates :visited_on, presence: true
  validates :cosite, presence: true, inclusion: { in: COSITE_VALUES }
  validates :age, numericality: true
  validates :uuid, presence: true, uniqueness: true
  validates :sex, inclusion: { in: SEX_VALUES }
  validates :race, inclusion: { in: RACE_VALUES }
end
