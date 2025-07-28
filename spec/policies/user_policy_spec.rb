require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class.new(current_user, user) }

  let(:user) { create(:user) }

  context "as admin" do
    let(:current_user) { create(:admin) }
    context "for visible user" do
      it { is_expected.to permit_all_actions }
    end

    context "for invisible user" do
      it { is_expected.to permit_all_actions }
    end

    context "for admin user" do
      it { is_expected.to permit_all_actions }
    end
  end

  context "as general user" do
    let(:current_user) { create :bruce }
    context "for owner" do
      let(:user) { current_user }
      it { is_expected.to forbid_only_actions(%i[destroy create new]) }
    end

    context "for visible user" do
      let(:user) { create :babs }
      it { is_expected.to permit_only_actions(%i[show]) }
    end

    context "for invisible user" do
      let(:user) { create :thomas }
      it { is_expected.to forbid_all_actions }
    end

    context "for admin user" do
      let(:user) { create :admin }
      it { is_expected.to forbid_all_actions }
    end
  end

  describe "UserPolicy::Scope" do
    subject { described_class::Scope.new(user, User) }
    let(:admin) { create(:admin) }
    let(:bruce) { create(:bruce) }
    let(:babs) { create(:babs) }
    let(:thomas) { create(:thomas) }
    context "as admin" do
      let(:user) { admin }
      it "should contain all users" do
        expect(subject.resolve).to include bruce
        expect(subject.resolve).to include babs
        expect(subject.resolve).to include thomas
        expect(subject.resolve).to include admin
      end
    end

    context "as general user" do
      let(:user) { bruce }
      it "should contain visible users" do
        expect(subject.resolve).to include bruce
        expect(subject.resolve).to include babs
        expect(subject.resolve).not_to include thomas
        expect(subject.resolve).not_to include admin
      end
    end

    context "as owner" do
      let(:user) { thomas }
      it "should contain all users including owned record" do
        expect(subject.resolve).to include bruce
        expect(subject.resolve).to include babs
        expect(subject.resolve).to include thomas
        expect(subject.resolve).not_to include admin
      end
    end
  end
end
