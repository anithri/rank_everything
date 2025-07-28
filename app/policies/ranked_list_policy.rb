class RankedListPolicy < ApplicationPolicy
  include TeamMembershipRole
  include VisibleTraits

  def team
    record.team
  end

  def show?
    visible? || contributor? || manager? || editor? || team_owner?
  end

  def create?
    admin? || team_owner? || manager?
  end

  def update?
    admin? || team_owner? || manager? || editor?
  end

  def destroy?
    admin? || team_owner?
  end

  class Scope < ApplicationPolicy::Scope
    include UserRole

    def resolve
      return scope.none if guest?
      return scope.all if admin?
      scope.visible
    end
  end
end
