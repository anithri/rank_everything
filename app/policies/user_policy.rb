class UserPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # region Actions
  def show?
    admin? || owner? || record.visible?
  end

  def create?
    admin?
  end

  def update?
    owner? || admin?
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
      return scope.all.order(:name) if user&.admin?

      scope.where(id: user&.id).or(User.visible).order(:name)
    end
  end
end
