FactoryBot.define do
  factory :user, class: User do
    sequence(:name) { |n| "User \#%04d" % n }
    sequence(:email_address) { |n| "user%04d@example.net" % n }
    password_digest { BCrypt::Password.create("password") }
    avatar_url { nil }
    site_role { :general }
    visible { true }

    factory :bruce do
      name { "Bruce Wayne" }
      email_address { "bwayne@wayneenterprises.com" }
    end

    factory :babs do
      name { "Barbara Gordon" }
      email_address { "babs@clocktower.org" }
    end

    factory :thomas do
      name { "Thomas Wayne" }
      visible { false }
      email_address { "twayne@gothamgeneral.com" }
      password_digest { BCrypt::Password.create("badpassword") }
    end

    factory :admin do
      name { "AdminUser" }
      email_address { "admin@rank-everything.example.com" }
      site_role { :admin }
      visible { false }
    end
  end
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
#  site_role       :integer          default("general")
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
