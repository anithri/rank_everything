# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def role_class
    if self.class.const_defined? :ROLE_CLASS
      self.class::ROLE_CLASS
    else
      raise NoMethodError, "You must define ROLE_CLASS in #{self.class}"
    end
  end

  def role
    @role ||= role_class.new(user, record)
  end

  def allow(*roles)
    role.allows *roles
  end
  alias_method :allows, :allow

  def show?
    # allow :public
    false
  end

  def create?
    # allow :public
    false
  end

  def new?
    # allow :public
    create?
  end

  def update?
    # allows :admin, :owner
    false
  end

  def edit?
    update?
  end

  def destroy?
    # allow :admin
    update?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NoMethodError, "You must define #resolve in #{self.class}"
    end

  end
end
