class AddUuidIndexToVisit < ActiveRecord::Migration
  def change
    Visit.transaction do
      add_index :visits, :uuid
    end
  end
end
