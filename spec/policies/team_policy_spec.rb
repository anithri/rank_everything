require 'rails_helper'

RSpec.describe TeamPolicy, type: :policy do
  subject { described_class.new(current_user, current_team) }

  let(:visible_team) { create(:team, visible: true) }
  let(:invisible_team) { create(:team, visible: false) }

  context "admin role" do
    let(:current_user) { create(:admin) }

    describe "authorization for" do
      describe "visible team" do
        let(:current_team) { visible_team }
        it { is_expected.to permit_all_actions }
      end
      describe "invisible team" do
        let(:current_team) { invisible_team }
        it { is_expected.to permit_all_actions }
      end
    end
  end

  context "owner role" do
    let(:owned_team) { create(:team) }
    let(:current_user) { owned_team.owner }

    describe "authorization for" do
      describe "owned team" do
        let(:current_team) { owned_team }

        it { is_expected.to forbid_only_actions(%i[destroy]) }
      end
    end
  end

  context "user role" do
    let(:current_user) { create(:user) }

    describe "authorization for" do
      describe "visible team" do
        let(:current_team) { visible_team }

        it { is_expected.to permit_only_actions(%i[show new create]) }
      end
      describe "invisible team" do
        let(:current_team) { invisible_team }

        it { is_expected.to permit_only_actions(%i[create new]) }
      end
    end
  end

  context "guest role" do
    let(:current_user) { nil }

    describe "auth for" do
      describe "visible team" do
        let(:current_team) { visible_team }

        it { is_expected.to permit_action(:show) }
      end
      describe "invisible team" do
        let(:current_team) { invisible_team }

        it { is_expected.to forbid_all_actions }
      end
    end
  end
end
