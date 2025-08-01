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

users = Array.new(20) do
  # try to keep email and name unique
  email = Faker::Internet.unique.email

  next if User.find_by(email_address: email)
  name = Faker::Name.unique.name
  User.find_by(name: name) || User.create(
    name: name,
    email_address: email,
    password: 'password',
    password_confirmation: 'password',
    visible: rand(4).nonzero?,
    site_role: :general,
  )
end

users.push(anithri)

membership_roles = [
  *Array.new(10) { :voter },
  *Array.new(5) { :contributor },
  *Array.new(3) { :editor },
  *Array.new(1) { :manager }
]

name = "WarRocket Ajax"
wra = Team.find_or_create_by(name: name)
wra.update(
  visible: true,
  owner: anithri,
)
wra.memberships.create(user: anithri, role: :manager)

users.sample(8).each do |u|
  wra.memberships.create(user: u, role: membership_roles.sample)
end

book_list = RankedList.create(
    team: wra,
    name: "Favorite Books",
    description: "What do you love to read?",
  )
album_list =  RankedList.create(
    team: wra,
    name: "Favorite Albums",
    description: "What do you love to listen to?",
  )
