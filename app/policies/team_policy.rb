class TeamPolicy < UserPolicy
  # region # Actions

  # TODO deep changes needed when team roles is implemented
  def show?
    return false if guest?
    return true if record.visible?

    admin? || owner?
  end

  # until it's decided if one user can own multiple teams
  def create?
    user?
  end

  private

  # endregion

  # region # Predicates
  private def owner?
    record.owner == user
  end
  # endregion

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all.order(:name) if user&.admin?

      scope.where(owner: user).or(Team.visible).order(:name)
    end
  end
end
