class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :name
      t.integer :infection_test_id
      t.uuid :uuid
      t.boolean :positive, default: true, null: false

      t.timestamps
    end
  end
end
