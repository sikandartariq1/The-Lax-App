class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :status, default: 0
      t.decimal :amount
      t.references :user, foreign_key: true
      t.references :old_salt, foreign_key: :true

      t.timestamps
    end
  end
end
