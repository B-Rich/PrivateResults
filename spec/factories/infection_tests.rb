# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :infection_test do
    sequence(:name) {|n| "Infection Test #{n}" }
    uuid { UUID.generate }

    infection
    visit
  end
end
