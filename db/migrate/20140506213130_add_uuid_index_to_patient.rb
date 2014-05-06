class AddUuidIndexToPatient < ActiveRecord::Migration
  def change
    Patient.transaction do
      add_index :patients, :uuid
    end
  end
end
