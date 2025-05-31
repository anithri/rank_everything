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
