# frozen_string_literal: true

module MemberRole
  extend ActiveSupport::Concern

  def role
    @role ||= user.memberships&.to_a.intersection(record.memberships).first
  end

  def public?
    role.nil?
  end

  def voter?
    role == :voter
  end

  def contributor?
    role == :contributor
  end

  def editor?
    role == :editor
  end

  def manager?
    role == :manager
  end

  included do
  end

  class_methods do
  end
end
