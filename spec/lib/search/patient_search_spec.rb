require 'spec_helper'

describe PatientSearch do
  let(:patient) { Patient.first || FactoryGirl.create(:patient) }

  it { should validate_presence_of(:patient_number) }
end
