class MembershipPolicy < ApplicationPolicy
  ROLE_CLASS = TeamMembershipRole.freeze
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  def team
    record.team
  end

  def role
    @role ||= role_class.new(user, team)
  end

  def show?
    allows :admin, :owner, :member
  end

  def create?
    allows :admin, :owner, :manager, :editor
  end

  def update?
    allows :admin, :owner, :manager, :editor
  end

  def destroy?
    allows :admin, :owner, :manager
  end

  private def owner?
    team.owner == user
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
