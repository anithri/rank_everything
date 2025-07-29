class UserPolicy < ApplicationPolicy
  ROLE_CLASS = UserRole
  def show?
    allows :visible, :admin, :guest
  end

  def create?
    allows :guest, :admin
  end

  def update?
    allows(:admin, :owner)
  end

  def destroy?
    allows :admin
  end

  private
  def visible?
    record.visible?
  end

  def owner?
    record == user
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.none unless user
      return scope.all if user&.admin?

      scope.where(id: user&.id).or(User.visible).order(:name)
    end
  end
end
