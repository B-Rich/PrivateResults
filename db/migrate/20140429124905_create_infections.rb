class CreateInfections < ActiveRecord::Migration
  def change
    create_table :infections do |t|
      t.string :name
      t.uuid :uuid

      t.timestamps
    end
  end
end
