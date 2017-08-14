class OldSalt < ApplicationRecord
  devise :database_authenticatable, :invitable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :profile_picture, ProfilePictureUploader

  has_many :appointments
  has_many :users, through: :appointments

  has_many :feedbacks
  has_many :feedback_users, through: :feedbacks

  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def stripe_account?
    stripe_account_id.present?
  end

end
