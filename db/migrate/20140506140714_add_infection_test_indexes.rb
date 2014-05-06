class AddInfectionTestIndexes < ActiveRecord::Migration
  def change
    InfectionTest.transaction do
      [:name, :visit_id, :infection_id].each do |column_name|
        add_index :infection_tests, column_name
      end
    end
  end
end
