require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:user) { create(:user) }
  let(:min) { Team::MIN_NAME_LENGTH }
  let(:max) { Team::MAX_NAME_LENGTH }

  describe "associations" do
    it { is_expected.to belong_to(:owner).class_name("User") }
    it { is_expected.to have_many(:memberships).dependent(:destroy) }
    it { is_expected.to have_many(:members).through(:memberships).source(:user) }
    it { is_expected.to have_many(:voter_memberships).class_name("Membership") }
    it { is_expected.to have_many(:voters).through(:voter_memberships).source(:user).class_name("User") }
    it { is_expected.to have_many(:contributor_memberships).class_name("Membership") }
    it { is_expected.to have_many(:contributors).through(:contributor_memberships).source(:user).class_name("User") }
    it { is_expected.to have_many(:editor_memberships).class_name("Membership") }
    it { is_expected.to have_many(:editors).through(:editor_memberships).source(:user).class_name("User") }
    it { is_expected.to have_many(:manager_memberships).class_name("Membership") }
    it { is_expected.to have_many(:managers).through(:manager_memberships).source(:user).class_name("User") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:owner) }
    it { is_expected.to validate_length_of(:name).is_at_least(min).is_at_most(max) }
  end

  describe "scopes" do
    let(:base) { create(:team) }
    let(:visible) { create(:team) }
    let(:invisible) { create(:invisible_team) }

    describe "default scope" do
      let(:teams) { [ base, visible, invisible ] }
      it "returns teams in name order" do
        expect(Team.all).to eq(teams)
      end
    end
    describe "visible scope" do
      let(:teams) { [ base, visible, invisible ] }
      it "returns teams in name order" do
        expect(Team.visible).to eq(teams.first(2))
      end
    end
  end
end

# == Schema Information
#
# Table name: teams
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  visible     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :bigint           not null
#
# Indexes
#
#  index_teams_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
