class TeamPolicy < UserPolicy
  include TeamMembershipRoles
  include VisibleTraits

  def team
    record
  end

  # TODO deep changes needed when team roles is implemented
  def show?
     visible? || admin? || member?
  end

  # until it's decided if one user can own multiple teams
  def create?
    public?
  end

  def update?
    admin? || team_owner? || manager? || editor?
  end

  def destroy?
    admin?
  end

  class Scope < ApplicationPolicy::Scope
    include UserRoles
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.visible if public?
      scope.all if admin?

      scope.where(owner: user).or(Team.visible).order(:name)
    end
  end
end
