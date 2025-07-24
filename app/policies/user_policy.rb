class UserPolicy < ApplicationPolicy
  include VisibleTraits

  # region Actions
  def show?
    admin? || owner? || visible?
  end

  def create?
    admin? || guest?
  end

  def update?
    admin? || owner?
  end

  # endregion

  # region Predicates
  private def owner?
    record == user
  end
  # endregion

  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.none unless user
      return scope.all if user&.admin?

      scope.where(id: user&.id).or(User.visible).order(:name)
    end
  end
end
