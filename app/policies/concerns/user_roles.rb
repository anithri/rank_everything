# frozen_string_literal: true

# concern for user based roles
module UserRoles
  extend ActiveSupport::Concern

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

  # included do
  # end
  #
  # class_methods do
  # end
end