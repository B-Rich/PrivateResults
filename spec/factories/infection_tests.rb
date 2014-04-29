# == Schema Information
#
# Table name: infection_tests
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  infection_id :integer
#  visit_id     :integer
#  uuid         :uuid
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :infection_test do
    sequence(:name) {|n| "Infection Test #{n}" }
    uuid { UUID.generate }

    infection
    visit
  end
end
