class MembershipPolicy < ApplicationPolicy
  ROLE_CLASS = MembershipRole

  def team
    record.team
  end

  def role
    @role ||= role_class.new(user, record)
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
