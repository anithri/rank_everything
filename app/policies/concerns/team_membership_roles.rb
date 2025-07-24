# frozen_string_literal: true

# This concern is meant to add role based rules to a policy
# I considered making the roles more dynamic but not hitting a pain point yet
# @example
#  class TeamPolicy < ApplicationPolicy
#    include TeamMembershipRoles
#    def team
#      record
#    end
#  end
#  class TeamMembershipPolicy < ApplicationPolicy
#    include TeamMembershipRoles
#    def team
#      record.team
#    end
#  end
module TeamMembershipRoles
  extend ActiveSupport::Concern

  # method must be implemented in the including class
  # @return [Team] extract the team from the record
  def team
    raise NotImplementedError, "Implement team in #{self.class.name}"
  end

  # get the membership record for the user and team
  def role
    return false unless user.respond_to?(:memberships)

    user.memberships.find_by(team: team).try(:role)
  end

  def team_owner?
    team.owner == user
  end

  # @return [Boolean] true if user is authenticated but has no role
  def public?
    user && role.nil?
  end

  # @return [Boolean] true if role is one of voter, contributor, editor, or manager
  def voter?
    role =="voter"
  end

  # @return [Boolean] true if role is one of contributor, editor, or manager
  def contributor?
    role =="contributor"
  end

  # @return [Boolean] true if role is editor or manager
  def editor?
    role =="editor"
  end

  def member?
    role.present?
  end

  # @return [Boolean] true if role is manager
  def manager?
    role =="manager"
  end

  included do
  end

  class_methods do
  end
end

class Team
  include TeamMembershipRoles

  def team
    record
  end

end
