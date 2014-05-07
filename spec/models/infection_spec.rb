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

require 'spec_helper'

describe Infection do
  let(:infection) { FactoryGirl.build(:infection) }

  it { should be_versioned }
  it { should have_many(:infection_tests) }
  it { should have_many(:results).through(:infection_tests) }

  describe '#valid?' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { expect(Infection.ensures_uuid?).to eq(true) }

    context 'given valid attributes' do
      it { expect(infection).to be_valid }
    end
  end
end
