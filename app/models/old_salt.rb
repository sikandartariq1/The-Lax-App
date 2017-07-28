class OldSalt < ApplicationRecord
  devise :database_authenticatable, :invitable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true
end
