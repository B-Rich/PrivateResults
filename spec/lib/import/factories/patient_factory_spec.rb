require 'spec_helper'

describe PatientFactory do
  let(:patient_number) { 10.to_s }

  describe 'make!' do
    context 'given an existing patient' do
      before(:each) { FactoryGirl.create(:patient, patient_number: patient_number) }

      it 'does not create a new record' do
        expect {
          PatientFactory.new(patient_number: patient_number).make!
        }.to change(Patient, :count).by(0)
      end

      it 'returns the corresponding record' do
        number_from_db = PatientFactory.new(patient_number: patient_number).make!.patient_number
        expect(number_from_db).to eq(patient_number)
      end
    end

    context 'given a new patient' do
      it 'creates a new record' do
        expect {
          PatientFactory.new(patient_number: patient_number).make!
        }.to change(Patient, :count).by(1)
      end
    end
  end
end
