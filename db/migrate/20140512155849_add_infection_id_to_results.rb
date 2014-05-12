class AddInfectionIdToResults < ActiveRecord::Migration
  def change
    Result.transaction do
      add_column :results, :infection_id, :integer
      add_index :results, :infection_id
    end
  end
end
