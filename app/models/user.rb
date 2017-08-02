class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :phone_no, presence: true

  has_many :appointments
  has_many :old_salts, through: :appointments

  mount_uploader :profile_picture, ProfilePictureUploader
  enum user_type: [:player, :coach]

  def full_name
    "#{first_name} #{last_name}"
  end
end
