require 'rails_helper'

RSpec.describe RankedListPolicy, type: :policy do
  subject { described_class.new(user, ranked_list) }

  let(:user) { create(:user) }
  let(:team) { create(:team, visible: false) }
  let(:visible_team) { create(:team, visible: true) }
  let(:ranked_list) { create(:ranked_list, team: team) }

  permissions ".scope" do
    before do
      create_list(:team, 2, visible: true) do |team, _|
        create(:ranked_list, team: team)
      end
    end
    it "returns no lists for guest users" do
      expect(described_class::Scope.new(nil, RankedList.all).resolve).to eq([])
    end

    it "returns all lists for admin user" do
      user.site_role = :admin
      expect(described_class::Scope.new(user, RankedList.all).resolve).to eq(RankedList.all)
    end

    it "returns all visible lists for public users" do
      expect(described_class::Scope.new(user, RankedList.all).resolve).to eq(RankedList.visible)
    end
  end

  permissions :show? do
    it "allows visible lists" do
      team.visible = true
      expect(subject.show?).to be_truthy
    end
    it "allows admin" do
      user.site_role = :admin
      expect(subject.show?).to be_truthy
    end
    it "allows owner" do
      team.owner = user
      expect(subject.show?).to be_truthy
    end
    it "allows manager" do
      team.memberships << create(:membership, user: user, role: :manager)
      expect(subject.show?).to be_truthy
    end
    it "allows editor" do
      team.memberships << create(:membership, user: user, role: :editor)
      expect(subject.show?).to be_truthy
    end
    it "allows contributor" do
      team.memberships << create(:membership, user: user, role: :contributor)
      expect(subject.show?).to be_truthy
    end

  end

  permissions :create?, :new do
    it "allows admin" do
      user.site_role = :admin
      expect(subject.create?).to be_truthy
      expect(subject.new?).to be_truthy
    end
    it "allows owner" do
      team.owner = user
      expect(subject.create?).to be_truthy
      expect(subject.new?).to be_truthy
    end
    it "allows manager" do
      team.memberships << create(:membership, user: user, role: :manager)
      expect(subject.create?).to be_truthy
      expect(subject.new?).to be_truthy
    end
  end

  permissions :update?, :edit do
    it "allows admin" do
      user.site_role = :admin
      expect(subject.edit?).to be_truthy
      expect(subject.update?).to be_truthy
    end
    it "allows owner" do
      team.owner = user
      expect(subject.edit?).to be_truthy
      expect(subject.update?).to be_truthy
    end
    it "allows manager" do
      team.memberships << create(:membership, user: user, role: :manager)
      expect(subject.edit?).to be_truthy
      expect(subject.update?).to be_truthy
    end
    it "allows editor" do
      team.memberships << create(:membership, user: user, role: :editor)
      expect(subject.edit?).to be_truthy
      expect(subject.update?).to be_truthy
    end
  end

  permissions :destroy? do
    it "allows admin" do
      user.site_role = :admin
      expect(subject.destroy?).to be_truthy
    end
    it "allows owner" do
      team.owner = user
      expect(subject.destroy?).to be_truthy
    end
  end
end
