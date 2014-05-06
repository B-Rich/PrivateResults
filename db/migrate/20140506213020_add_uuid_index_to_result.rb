class AddUuidIndexToResult < ActiveRecord::Migration
  def change
    Result.transaction do
      add_index :results, :uuid
    end
  end
end
