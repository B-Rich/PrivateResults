# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :result do
    sequence(:name) {|n| "Result #{n}" }
    uuid { UUID.generate }
    positive false

    infection_test
  end
end
