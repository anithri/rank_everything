# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  context "as guest user" do
    describe "GET /registration/new" do
      it "returns https success" do
        get new_registration_path

        expect(response).to have_http_status(:success)
      end
    end

    describe "POST /registration" do
      let(:params) { attributes_for :registration }
      it "creates a new user" do
        email = params[:email_address]
        post registration_path, params: { user: params }

        expect(User.find_by(email_address: email)).to be_truthy
        expect(response).to redirect_to user_path(User.find_by(email_address: email))
      end
      it "redirects to new_registration_path if invalid" do
        post registration_path, params: { user: attributes_for(:invalid_registration) }
        assert_template "registrations/new"
      end
    end
  end

  context "as authenticated user" do
    let(:user) { create :user }
    before { sign_in_as user }

    describe "GET /registration/user" do
      it "redirects user to user_path(Current.user)" do
        get new_registration_path
        expect(response).to redirect_to user_path(user)
      end
    end

    describe "PUT /registration" do
      it "redirects user to user_path(Current.user)" do
        get new_registration_path
        expect(response).to redirect_to user_path(user)
      end
    end
  end
end
