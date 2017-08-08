class Feedback < ApplicationRecord
  belongs_to :feedback_user, class_name: :User, foreign_key: :user_id
  belongs_to :feedback_old_salt, class_name: :OldSalt, foreign_key: :old_salt_id

  validates :comments, :feedback_user, :feedback_old_salt, presence: :true

  def feedback_entity(current_entity)
    if current_entity.try(:user_type)
      feedback_old_salt
    else
      feedback_user
    end
  end

end
