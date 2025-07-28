# frozen_string_literal: true

class ApplicationRole
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def allows(*roles)
    roles.any? { |role| self.send("#{role}?") }
  end
end
