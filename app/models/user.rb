class User < ApplicationRecord
  SOCIAL_SITES = [:facebook, :google_oauth2, :twitter]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: SOCIAL_SITES

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
    "#{first_name} #{last_name}".titleize
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.social_sites
    SOCIAL_SITES
  end

end
