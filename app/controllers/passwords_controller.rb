class PasswordsController < ApplicationController
  allow_unauthenticated_access

  before_action :set_user_by_token, only: %i[ edit update ]
  skip_after_action :verify_pundit_authorization

  # GET /passwords/new
  # provides the password reset form
  def new

  end

  # GET POST /passwords
  # submit the password reset form
  def create
    if user = User.find_by(email_address: params[:email_address])
      PasswordsMailer.reset(user).deliver_later
    end

    redirect_to new_session_path, notice: "Password reset instructions sent (if user with that email address exists)."
  end


  # GET /passwords/:token/edit
  # provides change password form
  def edit
  end

  # PUT /passwords/:token
  # submit the change password form
  def update
    @user.assign_attributes(password_params)
    if @user.save(context: :password_change)
      redirect_to new_session_path, notice: "Password has been reset."
    else
      redirect_to edit_password_path(params[:token]), alert: "Passwords did not match."
    end
  end

  private
  def password_params
    params.permit(:password, :password_confirmation)
  end
    def set_user_by_token
      @user = User.find_by_password_reset_token!(params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_password_path, alert: "Password reset link is invalid or has expired."
    end
end
