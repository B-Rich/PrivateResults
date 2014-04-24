require 'spec_helper'

describe Patient do
  let(:patient) { FactoryGirl.build(:patient) }

  describe '#valid?' do
    context 'given valid attributes' do
      it { expect(patient).to be_valid }
    end

    it { should validate_presence_of(:patient_number) }
    it { should validate_uniqueness_of(:patient_number) }
  end
end
