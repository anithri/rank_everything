require 'rails_helper'

RSpec.describe MembershipPolicy, type: :policy do
  subject { described_class }

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

  describe "guest" do
    # can show
    # can vote on open lists
  end
end
