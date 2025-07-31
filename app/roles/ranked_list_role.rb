# frozen_string_literal: true

class RankedListRole < TeamRole
  def team
    record.team
  end

  def visible?
    team.visible?
  end

  def owner?
    team.owner == user
  end
end
