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
  has_many :infection_tests, dependent: :destroy
  has_many :results

  # Valid values for cosite attribute
  # @api public
  COSITE_VALUES = %W{C D E SJ TB U}

  # Valid values for sex attribute
  # @api public
  SEX_VALUES = %W{M F T ?}

  # Valid values for race attribute
  # @api public
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

  # Valid values for sexual_preference attribute
  # @api public
  SEXUAL_PREFERENCE_VALUES = ['Opposite sex', 'Same sex', 'Either sex']

  # Valid values for sexual_identity attribute
  # @api public
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

  validates :phone_user_number, presence: true, numericality: true
  validates :phone_password_number, presence: true, numericality: true

  has_paper_trail
end
