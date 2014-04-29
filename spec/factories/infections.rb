# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :infection do
    sequence(:name) {|n| "Infection #{n}" }
    uuid { UUID.generate }
  end
end
