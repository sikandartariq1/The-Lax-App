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
    user = find_by_provider_and_uid(auth.provider, auth.uid)
    user || create_user(auth, user)
  end

  def self.social_sites
    SOCIAL_SITES
  end

  def self.create_user(auth, user)
    unless user || find_by_email(auth.info.email).present?
      user = new(provider: auth.provider, uid: auth.uid,
                  email: auth.info.email, password: Devise.friendly_token[0,20])
      user if user.save(validate: false)
    end
  end
end
