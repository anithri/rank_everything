require 'rails_helper'

RSpec.describe MembershipPolicy, type: :policy do
  subject { described_class.new(user, membership) }
  let(:user) { create(:user) }
  let(:team) { create(:team) }
  let(:membership) { create(:membership, user: user, team: team) }

  describe "admin" do
    # Can do everything
  end

  describe "team_owner" do
    # can do everything
  end

  describe "manager" do
    # can do everything except manage other managers
  end

  describe "editor" do
    # can do everything except to
  end
  describe "contributor" do
    # can show
    # can managage "voters"
    # can gst
    #
  end
  describe "voter" do
    # can show
    # can always vote
  end

  describe "public" do
    # can show
    # can vote on open lists
  end

  describe "guest" do
    # can show
    # can vote on open lists
  end

end
