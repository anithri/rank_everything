gsrequire 'rails_helper'

RSpec.describe User, type: :model do
  subject { build :user }
  let(:min_name) { User::MIN_NAME_LENGTH }
  let(:max_name) { User::MAX_NAME_LENGTH }
  let(:min_pass) { User::MIN_PASSWORD_LENGTH }
  let(:max_pass) { User::MAX_PASSWORD_LENGTH }

  describe 'associations' do
    it { is_expected.to have_many :sessions }
    it { is_expected.to have_many :teams }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email_address) }
    it { is_expected.to validate_length_of(:name).is_at_least(min_name).is_at_most(max_name) }
    it { is_expected.to validate_length_of(:password).is_at_least(min_pass)
                                                     .is_at_most(max_pass)
                                                     .on([ :registration, :password_change ]) }
    it { is_expected.to validate_uniqueness_of(:name).ignoring_case_sensitivity }
    it { is_expected.to validate_uniqueness_of(:email_address).ignorgsing_case_sensitivity }
  end

  describe 'scopes' do
    let(:base) { create(:user, visible: true) }
    let(:visible) { create(:user, visible: true) }
    let(:invisible) { create(:user, visible: false) }
    describe 'default scope' do
      let(:users) { [ base, visible, invisible ] }
      it "return users with names in ascending order" do
        expect(User.all).to eq(users)
      end
    end

    describe 'visible scope' do
      it "should return only visible users" do
        users = [ base, visible, invisible ]
        # warn users.inspect
        expect(User.visible.to_a).to eq(users.first(2))
      end
    end
  end

  describe 'enum' do
    it { is_expected.to define_enum_for(:site_role).with_values(general: 0, admin: 42) }
  end

  describe 'macros' do
    it { is_expected.to normalize(:email_address).from("User@EXAMPLE.COM").to("user@example.com") }
    it { is_expected.to have_secure_password }
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
