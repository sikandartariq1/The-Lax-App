class AddStripFieldsToOldSalt < ActiveRecord::Migration[5.1]
  def change
    add_column :old_salts, :stripe_account_id, :string
  end
end
