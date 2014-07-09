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
#  phone_user_number                :string(255)
#  phone_password_number            :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :visit do
    cosite "D"
    race "White"
    sequence(:age) {|n| 13 + n }
    sequence(:partners_last_6_months_5_or_more) {|n| n }
    sequence(:visited_on) {|n| 10.weeks.ago + n.minutes }
    sequence(:zip_code) {|n| "#{n}12345" }
    sex "M"
    sexual_identity "Straight"
    sexual_preference "Opposite sex"
    uuid { UUID.generate }
    sequence(:phone_user_number) {|n| "#{n * 100}#{n}" }
    sequence(:phone_password_number) {|n| "#{n * 100}#{n}" }

    patient
  end
end
