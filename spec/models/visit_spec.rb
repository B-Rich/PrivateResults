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

require 'spec_helper'

describe Visit do
  let(:visit) { FactoryGirl.build(:visit) }

  it { should belong_to(:patient) }

  describe '#valid?' do
    context 'given valid attributes' do
      it { expect(visit).to be_valid }
    end

    it { should validate_numericality_of(:age) }
    it { should validate_presence_of(:cosite) }
    it { should validate_numericality_of(:partners_last_6_months_5_or_more) }
    it { should validate_presence_of(:uuid) }
    it { should validate_presence_of(:visited_on) }


    context 'given invalid attributes' do
      it { should ensure_inclusion_of(:cosite).in_array(Visit::COSITE_VALUES) }
      it { should ensure_inclusion_of(:sex).in_array(Visit::SEX_VALUES) }
      it { should ensure_inclusion_of(:race).in_array(Visit::RACE_VALUES) }
      it { should ensure_inclusion_of(:sexual_preference).in_array(Visit::SEXUAL_PREFERENCE_VALUES) }
      it { should ensure_inclusion_of(:sexual_identity).in_array(Visit::SEXUAL_IDENTITY_VALUES) }
    end
  end
end
