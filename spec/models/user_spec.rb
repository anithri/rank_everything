require 'rails_helper'

RSpec.describe User, type: :model do
  let(:existing_user) { build :user }

  it "requires a valid email" do
    user = User.new(name: 'Batman', email_address: "", password: "password")
    expect(user).to_not be_valid
    user.email_address = nil
    expect(user).to_not be_valid
    user.email_address = "invalid"
    expect(user).to_not be_valid
    user.email_address = "johndoe@example.com"
    expect(user).to be_valid
  end

  it "requires a valid name" do
    user = User.new(name: '', email_address: "batman@batcave.org", password: "password")
    expect(user).to_not be_valid
    user.name = nil
    expect(user).to_not be_valid
    user.name = "short"
    expect(user).to_not be_valid
    user.name = SecureRandom.alphanumeric(73)
    expect(user).to_not be_valid
    user.name = "Batman"
    expect(user).to be_valid
  end


  it "requires a unique email" do
    existing_user = create :babs
    new_user = build :babs
    expect(existing_user.persisted?).to be_truthy
    expect(new_user).to be_invalid
  end

  context "on registration" do
    it "requires a valid password" do
      user = User.new(name: 'Barbara Gordon', email_address: "babs@clocktower.org")
      expect(user.valid?(:registration)).to be_falsey
      user.password = 'a' * 7
      expect(user.valid?(:registration)).to be_falsey
      user.password = 'é' * 72 # Too long in bytesize for bcrypt
      expect(user.valid?(:registration)).to be_falsey
      user.password = 'a' * 73
      expect(user.valid?(:registration)).to be_falsey
      user.password = 'a' * 72
      expect(user.valid?(:registration)).to be_truthy
    end
  end

  context "on authentication" do
    it "only accepts the right password" do
      babs = create :babs
      thomas = create :thomas
      thomas.password_digest = nil

      expect(User.authenticate_by(email_address: "babs@clocktower.org", password: nil)).to be_falsey
      expect(User.authenticate_by(email_address: "babs@clocktower.org", password: "")).to be_falsey
      expect(User.authenticate_by(email_address: "babs@clocktower.org", password: "wrong")).to be_falsey
      expect(User.authenticate_by(email_address: "babs@clocktower.org", password: "password")).to_not be_nil

      expect(User.authenticate_by(email_address: "twayne@gothamgeneral.com", password: "password")).to be_falsey
      expect(User.authenticate_by(email_address: "twayne@gothamgeneral.com", password: "")).to be_falsey
      expect(User.authenticate_by(email_address: "twayne@gothamgeneral.com", password: nil)).to be_falsey
      expect do
        User.authenticate_by(email_address: "existing_no_pass@example.com")
      end.to raise_exception(ArgumentError)
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
