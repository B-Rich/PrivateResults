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
#  visit_id          :integer
#  infection_id      :integer
#

require 'spec_helper'

describe Result do
  let(:result) { FactoryGirl.build(:result) }

  it { should belong_to(:infection_test) }
  it { should belong_to(:visit) }
  it { should belong_to(:infection) }

  it { should be_versioned }

  describe '#valid?' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:infection_test_id) }
    it { should validate_presence_of(:infection_id) }
    it { should validate_presence_of(:visit_id) }

    it { expect(Result.ensures_uuid?).to eq(true) }

    context 'given valid attributes' do
      it { expect(result).to be_valid }
    end

    context 'given invalid attributes' do
      context 'mismatched associations' do
        context 'infection_id and infection_test.infection_d' do
          before(:each) do
            result.infection_id = FactoryGirl.create(:infection)
          end
          it { expect(result.infection_id).not_to eq(result.infection_test.infection_id) }
          it { expect(result).not_to be_valid }
        end

        context 'visit_id and infection_test.vist_id' do
          before(:each) do
            result.visit_id = FactoryGirl.create(:visit)
          end
          it { expect(result.visit_id).not_to eq(result.infection_test.visit_id) }
          it { expect(result).not_to be_valid }
        end
      end
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
