class TeamPolicy < UserPolicy
  ROLE_CLASS = TeamRole

  def show?
    allows :visible, :admin, :owner, :member
  end

  def create?
    allows :public
  end

  def update?
    allows :admin, :owner, :manager, :editor
  end

  def destroy?
    allows :admin, :owner
  end

  private

  def visible?
    record.visible?
  end

  def owner?
    record.owner == user
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.visible unless user
      return scope.all if user.admin?

      scope.where(owner: user).or(Team.visible).order(:name)
    end
  end
end
