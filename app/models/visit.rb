# == Schema Information
#
# Table name: visits
#
#  id                               :integer          not null, primary key
#  patient_id                       :integer
#  uuid                             :uuid
#  visited_on                       :date
#  cosite                           :string(255)
#  sex                              :string(255)
#  race                             :string(255)
#  zip_code                         :string(255)
#  sexual_preference                :string(255)
#  sexual_identity                  :string(255)
#  age                              :integer
#  partners_last_6_months_5_or_more :integer
#  created_at                       :datetime
#  updated_at                       :datetime
#

class Visit < ActiveRecord::Base
  include EnsureUuid
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
  SEXUAL_PREFERENCE_VALUES = ['Opposite sex', 'Same sex', 'Either sex']
  SEXUAL_IDENTITY_VALUES = %W{Straight Gay Bisexual}

  validates :partners_last_6_months_5_or_more, numericality: true, allow_blank: true
  validates :visited_on, presence: true
  validates :cosite, presence: true, inclusion: { in: COSITE_VALUES }
  validates :age, numericality: true
  validates :uuid, presence: true, uniqueness: true
  validates :sex, inclusion: { in: SEX_VALUES }, allow_blank: true
  validates :race, inclusion: { in: RACE_VALUES }, allow_blank: true
  validates :sexual_preference, inclusion: { in: SEXUAL_PREFERENCE_VALUES }, allow_blank: true
  validates :sexual_identity, inclusion: { in: SEXUAL_IDENTITY_VALUES }, allow_blank: true
  has_paper_trail
end
