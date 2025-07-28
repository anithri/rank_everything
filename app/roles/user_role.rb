# frozen_string_literal: true
# concern for user based roles
class UserRole < ApplicationRole

  def visible?
    record&.visible?
  end

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

  # TODO is there a better way to do this? Seems a bit dodgy
  # @return [Boolean] true if user is the owner of the record
  def owner?
    return false unless user
    return record == user if record.is_a?(User)
    return record.user == user if record.respond_to?(:user)

    record.owner == user if record.respond_to?(:owner)
  end
end
