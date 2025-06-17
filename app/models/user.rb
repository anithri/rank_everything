class User < ApplicationRecord
  MAX_NAME_LENGTH = 64
  MIN_NAME_LENGTH = 6
  MAX_PASSWORD_LENGTH = 72
  MIN_PASSWORD_LENGTH = 8
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :site_role, dependent: :destroy
  delegate :role, :admin?, :general?, to: :site_role

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

  default_scope -> { order(:name).includes(:site_role) }
  scope :visible, -> { where(visible: true) }
end

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  avatar_url      :string
#  email_address   :string           not null
#  name            :string           not null
#  password_digest :string           not null
#  visible         :boolean          default(FALSE)
#  who_am_i        :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#  index_users_on_name           (name) UNIQUE
#  index_users_on_visible        (visible)
#
