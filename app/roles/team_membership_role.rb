# frozen_string_literal: true

# class to test role based access controls
class TeamMembershipRole < UserRole
  # method must be implemented in the including class
  # @return [Team] extract the team from the record
  def team
    record
  end

  def role
    team.memberships.find_by(user: user).try(:role)
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
end
