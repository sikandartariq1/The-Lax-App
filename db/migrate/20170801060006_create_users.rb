class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_bith
      t.string :phone_no
      t.integer :user_type
      t.json :profile_picture

      t.timestamps
    end
  end
end
