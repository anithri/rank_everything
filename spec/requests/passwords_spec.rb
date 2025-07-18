# spec/requests/passwords_spec.rb
# many thanks to https://dev.to/1klap/extending-the-ruby-on-rails-8-authentication-with-oauth-sign-in-and-the-missing-rspec-test-suite-4ia

require 'rails_helper'
require 'active_support/testing/time_helpers'
include ActiveSupport::Testing::TimeHelpers

RSpec.describe "Password", type: :request do
  let(:user) { create :user }
  before(:all) do
    ActionMailer::Base.deliveries.clear
  end

  # get password reset form.
  describe "GET /passwords/new" do
    it "returns http success" do
      get "/passwords/new"
      expect(response).to have_http_status(:success)
    end
  end

  # submit the password reset form
  describe "POST /passwords" do
    it "creating a password reset sends an email and show instructions", manager: true do
      # TODO: need to decide whether to enqueue or perform jobs
      # for the moment, request spec will perform jobs, while model spec will enqueue jobs
      perform_enqueued_jobs do
        post passwords_path, params: { email_address: user.email_address }
      end
      # expect do
      #   post passwords_path, params: { email_address: user.email_address }
      # end.to have_enqueued_email(PasswordMailer, :reset).exactly(:once)

      expect(response).to redirect_to new_session_path
      follow_redirect!
      assert_select "p", text: "Password reset instructions sent (if user with that email address exists)."

      expect(ActionMailer::Base.deliveries.size).to eq(1)

      ActionMailer::Base.deliveries.first.tap do |mail|
        content = mail.html_part.body.to_s
        token = content.match(/passwords\/(.+)\/edit"/)[1]
        expect(User.find_by_password_reset_token!(token)).to eq(user)
      end
    end
  end

  # get the password reset form
  # user gets the link from the password reset email.
  describe "GET /passwords/:token/edit" do
    it "returns http success" do
      get edit_password_path(user.password_reset_token)
      expect(response).to have_http_status(:success)
    end
  end

  # submit the password reset form
  describe "PUT /passwords/:token" do
    it "changes users password with a valid token" do
      token = user.password_reset_token

      expect do
        patch password_path(token), params: { password: "something", password_confirmation: "somethingelse" }
      end.not_to change { user.reload.password_digest }
      expect(response).to redirect_to(edit_password_path(token))

      # TODO understand why this is failing
      # FIXME
      expect do
        patch password_path(token), params: { password: "short", password_confirmation: "short" }
      end.not_to change { user.reload.password_digest }
      # but it did change, and redirects to /sessions/new.  which means there's a validation that doesn't work

      expect(response).to redirect_to(edit_password_path(token))

      expect do
        patch password_path(token), params: { password: "W3lcome?", password_confirmation: "W3lcome?" }
      end.to change { user.reload.password_digest }
      expect(response).to redirect_to(new_session_path)
      expect(User.authenticate_by(email_address: user.email_address, password: "W3lcome?")).to_not be_nil

      # Reset the token after a successful password change
      token = user.password_reset_token

      expect do
        patch password_path(token), params: { password: "W3lcome?", password_confirmation: "W3lcome?" }
      end.to change { user.reload.password_digest }
      expect(response).to redirect_to(new_session_path)
      expect(User.authenticate_by(email_address: user.email_address, password: "W3lcome?")).to_not be_nil
    end
  end

  it "does not change a user's password with an expired token" do
    token = user.password_reset_token
    travel_to 16.minutes.from_now
    expect do
      patch password_path(token), params: { password: "W3lcome?", password_confirmation: "W3lcome?" }
    end.not_to change { user.password_digest }
    expect(response).to redirect_to(new_password_path)
  end
end
