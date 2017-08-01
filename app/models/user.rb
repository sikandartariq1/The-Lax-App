class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :profile_picture, ProfilePictureUploader
  enum user_type: [:player, :coach]

  def full_name
    "#{first_name} #{last_name}"
  end
end
