class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :old_salt

  enum status: {
    pending: 0,
    accepted: 1,
    rejected: 2,
  }

  enum request_type: {
    player_analysis: 0,
    private_training: 1,
    coaching_training: 2,
  }

end
