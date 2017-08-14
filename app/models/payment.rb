class Payment < ApplicationRecord
  belongs_to :payment_user, class_name: :User, foreign_key: :user_id
  belongs_to :payment_old_salt, class_name: :OldSalt, foreign_key: :old_salt_id

  enum status: {
    pending: 0,
    paid: 1,
    rejected: 2,
  }

  def payment_entity(current_entity)
    return payment_old_salt if current_entity.is_a? User
    payment_user
  end

end
