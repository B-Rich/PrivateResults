# == Schema Information
#
# Table name: infections
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  uuid       :uuid
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :infection do
    sequence(:name) {|n| "Infection #{n}" }
    uuid { UUID.generate }
  end
end
