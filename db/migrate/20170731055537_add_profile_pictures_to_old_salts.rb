class AddProfilePicturesToOldSalts < ActiveRecord::Migration[5.1]
  def change
    add_column :old_salts, :profile_picture, :json
  end
end
