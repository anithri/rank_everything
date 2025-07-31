# frozen_string_literal: true

class RankedListRole < TeamRole
  def team
    record.team
  end

  def role
    team.memberships.find_by(user: user).try(:role)
  end

  def visible?
    team.visible?
  end

  def owner?
    team.owner == user
  end
end
