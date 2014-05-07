# == Schema Information
#
# Table name: results
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  infection_test_id :integer
#  uuid              :uuid
#  positive          :boolean          default(TRUE), not null
#  created_at        :datetime
#  updated_at        :datetime
#

require 'spec_helper'

describe Result do
  let(:result) { FactoryGirl.build(:result) }

  it { should belong_to(:infection_test) }
  it { should be_versioned }

  describe '#valid?' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:infection_test_id) }
    it { expect(Result.ensures_uuid?).to eq(true) }

    context 'given valid attributes' do
      it { expect(result).to be_valid }
    end
  end

  describe 'scopes' do
    let(:results) do
      (1..10).to_a.map {|i| FactoryGirl.create(:result, positive: (i % 2 == 0)) }
    end

    before(:each) { results }

    describe '.positive' do
      it { expect(Result.positive.count).to eq(5) }
    end

    describe '.negative' do
      it { expect(Result.negative.count).to eq(5) }
    end
  end
end
