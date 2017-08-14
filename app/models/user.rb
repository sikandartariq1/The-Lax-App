class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :phone_no, presence: true

  has_many :appointments
  has_many :old_salts, through: :appointments

  has_many :feedbacks
  has_many :feedback_old_salts, through: :feedbacks

  has_many :payments
  has_many :payment_old_salts, through: :payments

  mount_uploader :profile_picture, ProfilePictureUploader
  enum user_type: [:player, :coach]

  def full_name
    "#{first_name} #{last_name}"
  end
end
