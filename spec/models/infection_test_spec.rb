require 'spec_helper'

describe InfectionTest do
  let(:infection_test) { FactoryGirl.build(:infection_test) }

  it { should be_versioned }
  it { should belong_to(:infection) }
  it { should belong_to(:visit) }

  describe '#valid?' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:infection_id) }
    it { should validate_presence_of(:visit_id) }
    it { expect(InfectionTest.ensures_uuid?).to eq(true) }

    context 'given valid attributes' do
      it { expect(infection_test).to be_valid }
    end
  end
end
