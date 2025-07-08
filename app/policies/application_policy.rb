# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  delegate :admin?, to: :user

  # disabling in favor of scope
  # def index?
  #   false
  # end

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

  def destroy?
    false
  end

  private def admin?
    user&.admin?
  end

  private def general?
    user&.general?
  end

  private def guest?
    user.nil?
  end

  # when teams are entered play this becomes more complicated
  private def owner?
    record.user == user
  end

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
