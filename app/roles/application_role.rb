# frozen_string_literal: true

class ApplicationPermissions
  class << self
    def roles
      self.class::ROLES
    end
  end
end


class TeamPermissions < ApplicationPermissions
  ROLES = { voter: 0, contributor: 10, editor: 20, manager: 30 }
  def all_roles

  end

  def acts_as
    ROLES.invert
  end
end