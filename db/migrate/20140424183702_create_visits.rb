class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :patient_id
      t.uuid :uuid
      t.date :visited_on
      t.string :cosite
      t.string :sex
      t.string :race
      t.string :zip_code
      t.string :sexualpref
      t.string :sexualidentity
      t.integer :age
      t.integer :partners_last_6_months_5_or_more

      t.timestamps
    end
  end
end
