class FixColumnNameForUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :date_of_bith, :date_of_birth
  end
end
