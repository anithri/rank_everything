# frozen_string_literal: true

class VisibleTraitsPolicy < ApplicationPolicy
  include VisibleTraits
end

RSpec.describe VisibleTraitsPolicy, type: :policy do
  subject { described_class }
  let(:user) { create :user }

  describe "#visible?" do
    it "returns true if the record is visible" do
      policy = described_class.new(user, user )
      expect(policy.visible?).to be_truthy
    end
    it "returns false if the record is not visible" do
      policy = described_class.new(user, create(:user, visible: false))
      expect(policy.visible?).to be_falsey
    end
  end
end

