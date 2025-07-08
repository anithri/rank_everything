# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  #region # Actions
  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  #endregion

  #region # Predicates
  delegate :admin?, to: :user, private: true

  private def user?
    !!user
  end

  private def admin?
    user&.admin?
  end

  private def guest?
    user.nil?
  end

  private def owner?
    raise NoMethodError, "You must define #resolve in #{self.class}"
  end

  # TODO Integrate with a role engine after understanding better
  # plan is to allow a few roles for the team like publisher, editor, contributor, subscriber
  # private def has_role?(role)
  #   raise NoMethodError, "You must define #has_role? in #{self.class}"
  # end
  #endregion

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NoMethodError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
