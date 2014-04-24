# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :visit do
    cosite "D"
    race "White"
    sequence(:age) {|n| 13 + n }
    sequence(:partners_last_6_months_5_or_more) {|n| n }
    sequence(:visited_on) {|n| n.weeks.ago }
    sequence(:zip_code) {|n| "#{n}12345" }
    sex "M"
    sexualidentity "Straight"
    sexualpref "Opposite sex"
    uuid { UUID.generate }

    patient
  end
end
