class CreateFeedbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :feedbacks do |t|
      t.text :comments
      t.references :user, foreign_key: true
      t.references :old_salt, foreign_key: :true

      t.timestamps
    end
  end
end
