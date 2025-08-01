class RankedListPolicy < ApplicationPolicy
  ROLE_CLASS = RankedListRole.freeze

  def team
    record.team
  end

  def show?
    allows :visible, :admin, :owner, :manager, :editor, :contributor
  end

  def create?
    allow :admin, :owner, :manager
  end

  def update?
    allows :admin, :owner, :manager, :editor
  end

  def destroy?
    allows :admin, :owner
  end

  private
  def owner?
    team.owner == user
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.none unless user
      return scope.all if user.admin?

      scope.visible
    end
  end
end
