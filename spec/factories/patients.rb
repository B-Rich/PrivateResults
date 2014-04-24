# == Schema Information
#
# Table name: patients
#
#  id             :integer          not null, primary key
#  patient_number :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  uuid           :uuid
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :patient do
    sequence(:patient_number) {|n| "#{n}" }
    uuid { UUID.generate }
  end
end
