# find_or_create does not create site_roles relationship
admin = User.find_by(name: 'admin') || User.create(
  name: 'administrator',
  email_address: 'admin@rank-everything.example.com',
  password: 'admin_pass',
  password_confirmation: 'admin_pass',
  visible: false,
  site_role: :admin
)

anithri = User.find_by(name: 'anithri') || User.create(
  name: 'anithri',
  email_address: 'anithri@gmail.com',
  password: 'password',
  password_confirmation: 'password',
  visible: false,
  site_role: :general,
  avatar_url: "https://gravatar.com/avatar/45c541f7e93f3cb55c229495a9fbabba?s=400&d=robohash&r=x"
)

10.times do |n|
  # try to keep email and name unique
  email = Faker::Internet.email
  next if User.find_by(email_address: email)
  name = Faker::Name.name
  User.find_by(name: name) || User.create(
    name: name,
    email_address: email,
    password: 'password',
    password_confirmation: 'password',
    visible: rand(4).zero?,
    site_role: :general,
  )
end
