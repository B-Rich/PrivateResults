require 'spec_helper'

describe PatientSearch do
  let(:patient) { Patient.first || FactoryGirl.create(:patient) }

  it { should validate_presence_of(:patient_number) }

  let(:patient_search) { PatientSearch.new(patient_number: patient.patient_number) }

  describe '#patients' do
    context 'given a found patient' do
      it 'gives the right patient' do
        expect(patient_search.patients.first.id).to eq(patient.id)
      end

      it 'memoizes' do
        obj_id = patient_search.patients.first.object_id
        expect(obj_id).to eq(patient_search.patients.first.object_id)
      end
    end

    context 'given no existing patient' do
      it 'does not puke' do
      end
    end
  end
end
