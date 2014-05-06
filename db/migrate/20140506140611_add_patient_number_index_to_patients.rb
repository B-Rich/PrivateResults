class AddPatientNumberIndexToPatients < ActiveRecord::Migration
  def change
    Patient.transaction do
      add_index :patients, :patient_number
    end
  end
end
