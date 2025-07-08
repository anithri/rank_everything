require 'rails_helper'

RSpec.describe TeamPolicy, type: :policy do
  subject { described_class.new(current_user, current_team) }

  let(:visible_team) { create(:team) }
  let(:invisible_team) { create(:team, visible: false) }

  context "as an admin" do
    let(:current_user) { create(:admin) }

    describe "for all actions" do
      describe "for visible team" do
        let(:current_team) { visible_team }
        it { is_expected.to permit_all_actions }
      end
      describe "for invisible team" do
        let(:current_team) { invisible_team }
        it { is_expected.to permit_all_actions }
      end
    end
  end

  context "as an owner" do
    let(:current_user) { create(:user) }
    let(:owned_team) { create(:team, owner: current_user) }

    describe "for all actions" do
      describe "for owned team" do
        let(:current_team) { owned_team }
        it { is_expected.to permit_all_actions }
      end
    end
  end

  context "as a user" do
    let(:current_user) { create(:user) }
    let(:owned_team) { create(:team, owner: current_user) }

    describe "for all actions" do
      describe "for owned team" do
        let(:current_team) { owned_team }
        it { is_expected.to permit_all_actions }
      end
      describe "for visible team" do
        let(:current_team) { visible_team }
        it { is_expected.to permit_only_actions(%i[show new create]) }
      end
      describe "for invisible team" do
        let(:current_team) { invisible_team }
        it { is_expected.to forbid_all_actions }
      end
    end
  end

  context "as a guest" do
    let(:current_user) { nil }

    describe "for all actions" do
      describe "for visible team" do
        let(:current_team) { visible_team }
        it { is_expected.to forbid_all_actions }
      end
      describe "for invisible team" do
        let(:current_team) { invisible_team }
        it { is_expected.to forbid_all_actions }
      end
    end
  end
end
