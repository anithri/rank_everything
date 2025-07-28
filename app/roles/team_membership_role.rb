# frozen_string_literal: true

# class to testteam_role based access controls
class TeamMembershipRole < UserRole
  def team_role
    record.memberships.find_by(user: user).try(:role)
  end

  def visible?
    record&.visible?
  end

  def guest?
    user.nil?
  end

  def team_owner?
    record.owner == user
  end

  # @return [Boolean] true if user is authenticated but has noteam_role
  def public?
    user
  end

  # @return [Boolean] true ifteam_role is one of voter, contributor, editor, or manager
  def voter?
    team_role == "voter"
  end

  # @return [Boolean] true ifteam_role is one of contributor, editor, or manager
  def contributor?
    team_role == "contributor"
  end

  # @return [Boolean] true ifteam_role is editor or manager
  def editor?
    team_role == "editor"
  end

  def member?
    team_role.present?
  end

  # @return [Boolean] true ifteam_role is manager
  def manager?
    team_role == "manager"
  end
end
