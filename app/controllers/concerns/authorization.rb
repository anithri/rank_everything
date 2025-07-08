# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit::Authorization
    after_action :verify_pundit_authorization
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
end
