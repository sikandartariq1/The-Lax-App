class OldSalt < ApplicationRecord
  devise :database_authenticatable, :invitable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploaders :profile_picture, ProfilePictureUploader

  validates :first_name, :last_name, presence: true
end
