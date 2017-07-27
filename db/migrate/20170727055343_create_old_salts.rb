class CreateOldSalts < ActiveRecord::Migration[5.1]
  def change
    create_table :old_salts do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :phone_no

      t.timestamps
    end
  end
end
