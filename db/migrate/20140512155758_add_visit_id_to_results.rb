class AddVisitIdToResults < ActiveRecord::Migration
  def change
    Result.transaction do
      add_column :results, :visit_id, :integer
      add_index :results, :visit_id
    end
  end
end
