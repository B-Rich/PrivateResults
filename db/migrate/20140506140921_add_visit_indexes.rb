class AddVisitIndexes < ActiveRecord::Migration
  def change
    Visit.transaction do
      [:patient_id, :visited_on, :cosite].each do |column_name|
        add_index :visits, column_name
      end
    end
  end
end
