require 'spec_helper'

describe Patient do
  let(:patient) { FactoryGirl.build(:patient) }

  describe '#valid?' do
    context 'given valid attributes' do
      it { expect(patient).to be_valid }
    end

    it { should validate_presence_of(:patient_number) }
    it { should validate_uniqueness_of(:patient_number) }

    it { should validate_presence_of(:uuid) }

    context 'given invalid attributes' do
      context 'given a non-unique uuid' do
        it 'fails validation' do
          patient.save!

          other = FactoryGirl.build(:patient, uuid: patient.uuid)

          expect(other).not_to be_valid
        end
      end
    end
  end
end
