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

  class Scope < ApplicationPolicy::Scope
    def resolve
      if @user.admin?
        scope.includes(:team, :user).all
      elsif @user.nil?
        scope.includes(:team, :user)
             .where(users: { visible: true })
             .order("role desc, users.name asc")
      else
        scope.includes(:team, :user)
             .where(users: { visible: true })
             .or(scope.includes(:team, :user).where(user: @user))
             .order("role desc, users.name asc")
      end
    end
  end
end
