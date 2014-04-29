require 'spec_helper'

describe Infection do
  let(:infection) { FactoryGirl.build(:infection) }

  it { should be_versioned }

  describe '#valid?' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { expect(Infection.ensures_uuid?).to eq(true) }

    context 'given valid attributes' do
      it { expect(infection).to be_valid }
    end
  end
end
