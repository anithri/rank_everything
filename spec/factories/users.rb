FactoryBot.define do
  factory :user do
    name { |n| "User \##{n}" }
    email_address { |n| "user#{n}@example.net" }
    password_digest { BCrypt::Password.create("password") }

    factory :bruce do
      name { "Bruce Wayne" }
      email_address { "bwayne@wayneenterprises.com" }
    end

    factory :babs do
      name { "Barbara Gordon" }
      email_address { "babs@clocktower.org" }
    end

    factory :thomas do
      name { "Thomas Wayne"}
      email_address {"twayne@gothamgeneral.com"}
      password_digest { BCrypt::Password.create("badpassword") }
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
