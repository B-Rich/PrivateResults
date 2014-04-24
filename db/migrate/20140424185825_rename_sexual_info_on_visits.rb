class RenameSexualInfoOnVisits < ActiveRecord::Migration
  def change
    Visit.transaction do
      rename_column :visits, :sexualpref, :sexual_preference
      rename_column :visits, :sexualidentity, :sexual_identity
    end
  end
end
