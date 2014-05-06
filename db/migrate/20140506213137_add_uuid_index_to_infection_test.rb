class AddUuidIndexToInfectionTest < ActiveRecord::Migration
  def change
    InfectionTest.transaction do
      add_index :infection_tests, :uuid
    end
  end
end
