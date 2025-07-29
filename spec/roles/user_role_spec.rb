# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserRole do
  subject { described_class.new(user, record) }
  let(:record) { user }

  context 'With no user' do
    let(:user) { nil }
    it "guest? should be true" do
      expect(subject.guest?).to be_truthy
    end
    it "public? should be false" do
      expect(subject.public?).to be_falsey
    end
    it "admin? should be false" do
      expect(subject.admin?).to be_falsey
    end
  end

  context 'With a general user' do
    let(:user) { create(:user) }
    let(:record) { create(:user) }

    it "guest? should be true" do
      expect(subject.guest?).to be_falsey
    end
    it "public? should be false" do
      expect(subject.public?).to be_truthy
    end
    it "admin? should be false" do
      expect(subject.admin?).to be_falsey
    end
  end

  context 'With a admin user' do
    let(:user) { create(:admin) }
    let(:record) { create(:user) }

    it "guest? should be true" do
      expect(subject.guest?).to be_falsey
    end
    it "public? should be true" do
      expect(subject.public?).to be_truthy
    end
    it "admin? should be true" do
      expect(subject.admin?).to be_truthy
    end
  end

  describe "#owner?" do
    context "when no user" do
      let(:user) { nil }
      let(:record) { create(:user) }

      it "returns false" do
        expect(subject.owner?).to be_falsey
      end
    end
    context "when non member" do
      let(:user) { create(:user) }
      let(:record) { create(:user) }

      it "returns false" do
        expect(subject.owner?).to be_falsey
      end
    end
    context "when user is record" do
      let(:user) { create(:user) }

      it "returns true" do
        expect(subject.owner?).to be_truthy
      end
    end
  end
end
