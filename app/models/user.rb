class User < ApplicationRecord
  MAX_NAME_LENGTH = 64
  MIN_NAME_LENGTH = 6
  MAX_PASSWORD_LENGTH = 72
  MIN_PASSWORD_LENGTH = 8
  has_secure_password
  has_many :sessions, dependent: :destroy

  validates :name,
            presence: true,
            length: { minimum: MIN_NAME_LENGTH, maximum: MAX_NAME_LENGTH },
            uniqueness: { case_sensitive: false }
  validates :email_address,
            presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: { case_sensitive: false }
  validates :password, on: [ :registration, :password_change ],
            presence: true,
            length: { minimum: MIN_PASSWORD_LENGTH, maximum: MAX_PASSWORD_LENGTH }

  normalizes :name, with: ->(n) { n.strip.downcase }
  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
