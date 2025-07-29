# frozen_string_literal: true

# class to test team_role based access controls
class MembershipRole < TeamRole
  def team
    record.team
  end

  def role
    return false unless record.user == user
    record.role
  end

  def visible?
    team.visible?
  end

  def owner?
    team.owner == user
  end
end
