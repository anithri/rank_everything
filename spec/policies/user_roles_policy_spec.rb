# frozen_string_literal: true
require 'rails_helper'

class UserRolesPolicy < ApplicationPolicy
  include UserRoles
end

RSpec.describe UserRolesPolicy, type: :policy do
  subject { described_class.new(user, user) }

  context "nil_user" do
    let(:user) { nil }
    describe "#guest?" do
      it "returns true" do
        expect(subject.guest?).to be_truthy
      end
    end
    describe "#public?" do
      it "returns false" do
        expect(subject.public?).to be_falsey
        end
    end
    describe "#admin?" do
      it "returns false" do
        expect(subject.admin?).to be_falsey
        end
      end
  end

  context "public_user" do
    let(:user) { create(:user) }
    describe "#guest?" do
      it "returns false" do
        expect(subject.guest?).to be_falsey
      end
    end
    describe "#public?" do
      it "returns true" do
        expect(subject.public?).to be_truthy
      end
    end
    describe "#admin?" do
      it "returns false" do
        expect(subject.admin?).to be_falsey
      end
    end
  end

  context "admin_user" do
    let(:user) { create(:user, site_role: "admin") }
    describe "#guest?" do
      it "returns false" do
        expect(subject.guest?).to be_falsey
      end
    end
    describe "#public?" do
      it "returns false" do
        expect(subject.public?).to be_truthy
      end
    end
    describe "#admin?" do
      it "returns true" do
        expect(subject.admin?).to be_truthy
      end
    end
  end
end

