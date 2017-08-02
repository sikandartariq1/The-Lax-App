class OldSalt < ApplicationRecord
  devise :database_authenticatable, :invitable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :profile_picture, ProfilePictureUploader

  has_many :appointments
  has_many :users, through: :appointments

  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
