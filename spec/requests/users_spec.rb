require 'rails_helper'
require_relative '../support/shared_examples/unauthenticated_requests'
RSpec.describe "Users", type: :request do
  let(:user) { create(:user, id: 1) }
  let(:admin) { create :admin } # using admin here, authorization convered in UserPolicy

  describe "For Guest User" do
    include_examples("unauthenticated requests", :get, "/users")
    include_examples("unauthenticated requests", :get, "/users/new")
    include_examples("unauthenticated requests", :post, "/users")
    include_examples("unauthenticated requests", :get, "/users/1")
    include_examples("unauthenticated requests", :get, "/users/1/edit")
    include_examples("unauthenticated requests", :patch, "/users/1")
  end

  describe "For Admin User" do
    before { sign_in_as(admin) }


  end

  # describe "GET /users" do
  #   context "authenticated user" do
  #     before { sign_in_as(admin) }
  #
  #     it "returns http success" do
  #       get users_path
  #
  #       expect(response).to have_http_status(:success)
  #       # TODO view specs
  #     end
  #   end
  #
  #   context "guest user" do
  #     it "redirects to sign in page" do
  #       get users_path
  #       expect(response).to redirect_to(new_session_path)
  #     end
  #   end
  # end
  #
  # describe "GET /user/:id" do
  #   it "returns http success" do
  #     get user_path(user)
  #
  #     expect(response).to have_http_status(:success)
  #     # TODO view specs
  #   end
  # end

  # describe "{PATCH} /user/:id" do
  #   it "returns http success" do
  #     get user_path(user)
  #
  #     expect(response).to have_http_status(:success)
  #     # TODO view specs
  #   end
  # end
  #
  # describe "DELETE /user/:id" do
  #   it "returns http success" do
  #     get user_path(user)
  #
  #     expect(response).to have_http_status(:success)
  #     # TODO view specs
  #   end
  # end
  # describe "GET /user/:id" do
  #   it "returns http success" do
  #     user = create :user
  #     get user_path(user)
  #     expect(response).to have_http_status(:success)
  #     # TODO view specs
  #   end
  # end
  # describe "GET /user/:id" do
  #   it "returns http success" do
  #     user = create :user
  #     get user_path(user)
  #     expect(response).to have_http_status(:success)
  #     # TODO view specs
  #   end
  # end
  # describe "GET /user/:id" do
  #   it "returns http success" do
  #     user = create :user
  #     get user_path(user)
  #     expect(response).to have_http_status(:success)
  #     # TODO view specs
  #   end
  # end
end
