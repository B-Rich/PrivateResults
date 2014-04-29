class CreateInfectionTests < ActiveRecord::Migration
  def change
    create_table :infection_tests do |t|
      t.string :name
      t.integer :infection_id
      t.integer :visit_id
      t.uuid :uuid

      t.timestamps
    end
  end
end
