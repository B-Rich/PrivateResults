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
    end
  end
end
