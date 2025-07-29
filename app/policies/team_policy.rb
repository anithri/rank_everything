class TeamPolicy < UserPolicy
  ROLE_CLASS = TeamRole

  def show?
    allows :visible, :admin, :owner, :member
  end

  def create?
    allow :public
  end

  def update?
    allows :admin, :owner, :manager, :editor
  end

  def destroy?
    allow :admin
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
      scope.visible if user
      scope.all if user.admin?

      scope.where(owner: user).or(Team.visible).order(:name)
    end
  end
end
