require 'rails_helper'
require_relative '../support/shared_examples/unauthenticated_requests'
require_relative '../support/shared_examples/admin_requests'
RSpec.describe "Users", type: :request do
  describe "as admin" do
    let(:user) { create(:user, id: 1) }
    before { sign_in_as(create :admin) }

    it "allows /users" do
      get users_path
      expect(response).to have_http_status(:success)
    end
    it "allows /users/new" do
      get new_user_path
      expect(response).to have_http_status(:success)
    end
    it "allows /user/1" do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end
    it "allows /user/1/edit" do
      get edit_user_path(user)
      expect(response).to have_http_status(:success)
    end

    it "creates a new user" do
      params = { name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password, }
      patch new_user_path, params: params
    end
  end

  describe "as user" do
    let(:user) { create(:user, id: 1) }
    let(:another_user) { create(:user, id: 2) }
    let(:invisible_user) { create(:user, id: 3, visible: false) }
    before do
      sign_in_as(user)
    end

    it "allows /users" do
      get users_path
      expect(response).to have_http_status(:success)
    end
    it "denies /users/new" do
      get new_user_path
      expect(response).to redirect_to root_path
    end
    it "allows /users/2 if visible" do
      get user_path(another_user)
      expect(response).to have_http_status(:success)
    end
    it "denies /users/2 if invisible" do
      get user_path(invisible_user)
      expect(response).to redirect_to root_path
    end
    it "denies /users/2/edit" do
      get edit_user_path(another_user)
      expect(response).to redirect_to root_path
    end

    describe "as owner" do
      it "allows /user/1" do
        get user_path(user)
        expect(response).to have_http_status(:success)
      end
      it "allows /user/1/edit" do
        get edit_user_path(user)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "For Guest User" do
    include_examples("unauthenticated requests", :get, "/users")
    include_examples("unauthenticated requests", :get, "/users/new")
    include_examples("unauthenticated requests", :post, "/users")
    include_examples("unauthenticated requests", :get, "/users/1")
    include_examples("unauthenticated requests", :get, "/users/1/edit")
    include_examples("unauthenticated requests", :patch, "/users/1")
  end
end
