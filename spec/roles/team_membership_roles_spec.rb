# frozen_string_literal: true
require 'rails_helper'

RSpec.describe TeamMembershipRole do
  subject { described_class.new(user, team) }
  let(:membership) { create(:membership) }

  let(:user) { membership.user }
  let(:team) { membership.team }

  describe "#guest?" do
    let(:user) { nil }

    context "when user is not logged in" do
      it { expect(subject.guest?).to be_truthy }
    end

    context "when user is logged in" do
      let(:user) { create(:user) }
      it { expect(subject.guest?).to be_falsey }
    end
  end

  describe "#public?" do
    context "when user is not logged in" do
      let(:user) { nil }
      it { expect(subject.public?).to be_falsey }
    end

    context "when user is logged in" do
      let(:user) { create(:user) }
        it { expect(subject.public?).to be_truthy }
    end
  end

  describe "#member?" do
    context "when no user" do
      let(:user) { nil }
      it{ expect(subject.member?).to be_falsey }
    end

    context "when non member use" do
      let(:user) { create(:user) }
      it { expect(subject.member?).to be_falsey }
    end

    context "when member user" do
      it { expect(subject.member?).to be_truthy }
    end
  end

  describe "#voter?" do
    context "when no user" do
      let(:user) { nil }
      it { expect(subject.voter?).to be_falsey }
    end

    context "when non member use" do
      let(:user) { create(:user) }
      it { expect(subject.voter?).to be_falsey }
    end

    context "when member user, with different role" do
      # create another user and create a membership for them with a different role
      let(:another_user) { create :user }
      let(:not_voter) { create :membership, user: another_user, team: team, role: "contributor" }

      it "returns false" do
        policy = described_class.new(another_user, team)
        expect(policy.voter?).to be_falsey
      end
    end

    context "when member user has the voter role" do
      it { expect(subject.voter?).to be_truthy }
    end
  end

  describe "#contributor?" do
    context "when no user" do
      let(:user) { nil }
      it { expect(subject.contributor?).to be_falsey }
    end

    context "when non member use" do
      let(:user) { create(:user) }
      it { expect(subject.contributor?).to be_falsey }
    end

    context "when member user, with different role" do
      # create another user and create a membership for them with a different role
      let(:another_user) { create :user }
      let(:not_contributor) { create :membership, user: another_user, team: team, role: "voter" }

      it "returns false" do
        policy = described_class.new(another_user, team)
        expect(policy.contributor?).to be_falsey
      end
    end

    context "when member user has the contributor role" do
      let(:membership) { create(:membership, role: "contributor") }

      it "returns true" do
        expect(subject.contributor?).to be_truthy
      end
    end
  end

  describe "#editor?" do
    context "when no user" do
      let(:user) { nil }
      it "returns false" do
        expect(subject.editor?).to be_falsey
      end
    end

    context "when non member use" do
      let(:user) { create(:user) }
      it "returns false" do
        expect(subject.editor?).to be_falsey
      end
    end

    context "when member user, with different role" do
      # create another user and create a membership for them with a different role
      let(:another_user) { create :user }
      let(:not_editor) { create :membership, user: another_user, team: team, role: "voter" }

      it "returns false" do
        policy = described_class.new(another_user, team)
        expect(policy.editor?).to be_falsey
      end
    end

    context "when member user has the editor role" do
      let(:membership) { create(:membership, role: "editor") }

      it "returns true" do
        expect(subject.editor?).to be_truthy
      end
    end
  end

  describe "#manager?" do
    context "when no user" do
      let(:user) { nil }
      it "returns false" do
        expect(subject.manager?).to be_falsey
      end
    end

    context "when non member use" do
      let(:user) { create(:user) }
      it "returns false" do
        expect(subject.manager?).to be_falsey
      end
    end

    context "when member user, with different role" do
      # create another user and create a membership for them with a different role
      let(:another_user) { create :user }
      let(:not_manager) { create :membership, user: another_user, team: team, role: "voter" }

      it "returns false" do
        policy = described_class.new(another_user, team)
        expect(policy.manager?).to be_falsey
      end
    end

    context "when member user has the manager role" do
      let(:membership) { create(:membership, role: "manager") }

      it { expect(subject.manager?).to be_truthy }
    end
  end
end

