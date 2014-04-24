# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :patient do
    sequence(:patient_number) {|n| "#{n}" }
    uuid { UUID.generate }
  end
end
