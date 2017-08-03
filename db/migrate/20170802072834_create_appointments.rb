class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.integer :status, default: 0
      t.integer :request_type
      t.text :note
      t.date :requested_date
      t.time :requested_time
      t.string :location
      t.references :user, foreign_key: true
      t.references :old_salt, foreign_key: :true

      t.timestamps
    end
  end
end
