require 'rails_helper'

RSpec.describe "Pages", type: :request do
  context "when not logged in" do
    describe "GET /home" do
      it "returns http redirect" do
        get "/home"
        expect(response).to redirect_to(:new_session)
      end
    end

    describe "GET /about" do
      it "returns http redirect " do
        get "/about"
        expect(response).to redirect_to(:new_session)
      end
    end
  end

  context "when not logged in" do
    let(:user) { create(:user, email_address: "test_user@example.test") }
    before { sign_in_as(user) }

    describe "GET /home" do
      it "returns http redirect" do
        get "/home"
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET /about" do
      it "returns http redirect " do
        get "/about"
        expect(response).to have_http_status(:success)
      end
    end
  end
end
