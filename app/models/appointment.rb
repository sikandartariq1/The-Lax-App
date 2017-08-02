class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :old_salt

  enum request_status: [:pending, :accepted, :rejected]
  enum request_type: [:coaching, :analyzing]

end
