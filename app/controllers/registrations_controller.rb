class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: [ :new, :create ]
  skip_after_action :verify_pundit_authorization

  # TODO deny a logged in person to register a new user.

  def new
    redirect_if_current_user
    @user = User.new
  end

  def create
    redirect_if_current_user
    @user = User.new(user_params)
    if @user.save(context: :registration)
      start_new_session_for(@user)
      redirect_to user_path(@user), notice: "Registered successfully"
    else
      render :new
    end
  end

  private

  def redirect_if_current_user
    resume_session
    redirect_to(user_path(Current.user), notice: "one user account per person please") if Current.user
  end


  def user_params
    params.require(:user)
          .permit(:name, :email_address, :password, :password_confirmation)
          # .tap {|p| warn p.inspect }
  end
end
