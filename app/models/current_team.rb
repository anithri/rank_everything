# frozen_string_literal: true

class CurrentTeam < ActiveSupport::CurrentAttributes
  attribute :team, :team_role, :team_policy
  def user
    Current.user
  end
  def role
    self.team_role ||= TeamRole.new(user, team)
  end
  def policy
    self.team_policy ||= TeamPolicy.new(user, team)
  end
end
