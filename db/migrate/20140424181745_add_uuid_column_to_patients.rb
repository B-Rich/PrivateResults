class AddUuidColumnToPatients < ActiveRecord::Migration
  def change
    Patient.transaction do
      add_column :patients, :uuid, :uuid
    end
  end
end
