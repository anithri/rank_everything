# frozen_string_literal: true

# concern for user based roles
class UserRole < ApplicationRole
  # @return [Boolean] true if user is not present
  def guest?
    user.nil?
  end

  # @return [Boolean] true if user is present
  def public?
    user
  end

  # @return [Boolean] true if user has a site_role of admin
  def admin?
    user&.admin?
  end

  def visible?
    record.visible?
  end

  def owner?
    record == user
  end
end
