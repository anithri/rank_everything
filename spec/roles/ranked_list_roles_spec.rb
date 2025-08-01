# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RankedListRole do
  subject { described_class.new(user, ranked_list) }
  let(:user) { create(:user) }
  let(:team) { create(:team, owner: create(:user)) }
  let(:owned_team) { create(:team, owner: user) }
  let(:ranked_list) { create(:ranked_list, team: team) }

  describe "#guest? and public?" do
    context "when user is not logged in" do
      let(:user) { nil }

      it { expect(subject.guest?).to be_truthy }
      it { expect(subject.public?).to be_falsey }
    end

    context "when user is logged in" do
      it { expect(subject.guest?).to be_falsey }
      it { expect(subject.public?).to be_truthy }
    end
  end

  describe "#member?" do
    context "when no user" do
      let(:user) { nil }
      it { expect(subject.member?).to be_falsey }
    end

    context "when non member user" do
      it { expect(subject.member?).to be_falsey }
    end

    context "when member user" do
      before { team.memberships << create(:membership, user:)  }
      it do
        expect(subject.member?).to be_truthy
      end
    end
  end

  describe "#voter?" do
    context "when no user" do
      let(:user) { nil }
      it { expect(subject.voter?).to be_falsey }
    end

    context "when non member use" do
      it { expect(subject.voter?).to be_falsey }
    end

    context "when member user, with different role" do
      let(:membership) { create(:membership, user:, team:) }

      # create another user and create a membership for them with a different role
      let(:another_user) { create :user }
      let(:not_voter_member) { create :membership, user: another_user, team: team, role: "contributor" }

      it "returns false" do
        policy = described_class.new(another_user, not_voter_member)
        expect(policy.voter?).to be_falsey
      end
    end

    context "when member user has the voter role" do
      before { team.memberships << create(:membership, user:)  }
      it { expect(subject.voter?).to be_truthy }
    end
  end

  describe "#contributor?" do
    context "when no user" do
      let(:user) { nil }
      it { expect(subject.contributor?).to be_falsey }
    end

    context "when non member use" do
      it { expect(subject.contributor?).to be_falsey }
    end

    context "when member user, with different role" do
      # create another user and create a membership for them with a different role
      let(:another_user) { create :user }
      let(:not_contributor_member) { create :membership, user: another_user, team: team, role: "voter" }

      it "returns false" do
        policy = described_class.new(another_user, not_contributor_member)
        expect(policy.contributor?).to be_falsey
      end
    end

    context "when member user has the contributor role" do
      before { team.memberships << create(:membership, user:, role: "contributor")  }

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
      let(:not_editor_member) { create :membership, user: another_user, team: team, role: "voter" }

      it "returns false" do
        policy = described_class.new(another_user, not_editor_member)
        expect(policy.editor?).to be_falsey
      end
    end

    context "when member user has the editor role" do
      before { team.memberships << create(:membership, user:, role: "editor")  }

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
      let(:not_manager_member) { create :membership, user: another_user, team: team, role: "voter" }

      it "returns false" do
        policy = described_class.new(another_user, not_manager_member)
        expect(policy.manager?).to be_falsey
      end
    end

    context "when member user has the manager role" do
      before { team.memberships << create(:membership, user:, role: "manager")  }

      it { expect(subject.manager?).to be_truthy }
    end
  end
end
