class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]

  # GET /users or /users.json
  def index
    @users = policy_scope(User.order(:name).includes(memberships: :team))

    add_breadcrumb "Users", users_path
  end

  # GET /users/1 or /users/1.json
  def show
    authorize @user

    add_breadcrumb "Users", users_path
    add_breadcrumb @user.name, user_path(@user)
  end

  # GET /users/new
  def new
    @user = User.new
    authorize @user

    add_breadcrumb "Users", users_path
    add_breadcrumb "New User", new_user_path
  end

  # GET /users/1/edit
  def edit
    authorize @user

    add_breadcrumb "Users", users_path
    add_breadcrumb @user.name, user_path(@user)
    add_breadcrumb "Edit", edit_user_path(@user)
  end

  # POST /users or /users.json
  def create
    @user = User.new(new_user_params)
    authorize @user

    respond_to do |format|
      if @user.save(context: :registration)
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    authorize @user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.fetch(:user).require([ :name, :visible, :who_am_i ])
  end

  def new_user_params
    params.fetch(:user).require([ :name, :email_address, :visible, :who_am_i, :password, :password_confirmation ])
  end
end
