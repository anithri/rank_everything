class UserPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  def show?
    admin? || owner? || record.visible?
  end

  def create?
    admin?
  end

  def new?
    create?
  end

  def update?
    owner? || admin?
  end

  def edit?
    update?
  end

  def destroy?
    admin?
  end

  private def owner?
    record == user
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.all.order(:name) if user&.admin?

      scope.where(id: user&.id).or(User.visible).order(:name)
    end
  end
end
