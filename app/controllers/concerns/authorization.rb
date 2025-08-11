# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit::Authorization
    after_action :verify_pundit_authorization

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  def pundit_user
    Current.user
  end

  private
  def verify_pundit_authorization
    if action_name == "index"
      verify_policy_scoped
    else
      verify_authorized
    end
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    warn "User not authorized to perform action: #{action_name}"
    redirect_back_or_to(root_path)
  end
end
