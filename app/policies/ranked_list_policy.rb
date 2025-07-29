class RankedListPolicy < ApplicationPolicy

  ROLE_CLASS = MembershipRole.freeze

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

    def resolve
      return scope.none unless user
      return scope.all if user.admin?

      scope.visible
    end
  end
end
