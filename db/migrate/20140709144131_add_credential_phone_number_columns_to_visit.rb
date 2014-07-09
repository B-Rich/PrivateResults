class AddCredentialPhoneNumberColumnsToVisit < ActiveRecord::Migration
  def change
    Visit.transaction do
      add_column :visits, :phone_user_number, :string
      add_column :visits, :phone_password_number, :string

      add_index :visits, :phone_user_number
      add_index :visits, :phone_password_number
    end
  end
end
