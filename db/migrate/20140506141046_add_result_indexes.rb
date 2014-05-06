class AddResultIndexes < ActiveRecord::Migration
  def change
    Result.transaction do
      [:name, :infection_test_id, :positive].each do |column_name|
        add_index :results, column_name
      end
    end
  end
end
