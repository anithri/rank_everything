class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  validates :name,
            presence: true,
            length: { minimum: 6, maximum: 64 },
            uniqueness: { case_sensitive: false }
  validates :email_address,
            presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: { case_sensitive: false }
  validates :password, on: [ :registration, :password_change ],
            presence: true,
            length: { minimum: 8, maximum: 72 }

  normalizes :name, with: ->(n) { n.strip.downcase }
  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
