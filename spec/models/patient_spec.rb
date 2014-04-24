# == Schema Information
#
# Table name: patients
#
#  id             :integer          not null, primary key
#  patient_number :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  uuid           :uuid
#

require 'spec_helper'

describe Patient do
  let(:patient) { FactoryGirl.build(:patient) }

  it { should have_many(:visits) }

  describe '#valid?' do
    context 'given valid attributes' do
      it { expect(patient).to be_valid }
    end

    it { should validate_presence_of(:patient_number) }
    it { should validate_uniqueness_of(:patient_number) }

    it { expect(Patient.ensures_uuid?).to eq(true) }
    context 'given invalid attributes' do
      context 'uuid' do
        context 'non-unique' do
          it 'fails validation' do
            patient.save!

            other = FactoryGirl.build(:patient, uuid: patient.uuid)

            expect(other).not_to be_valid
          end
        end
      end
    end
  end
end
