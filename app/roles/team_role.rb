# frozen_string_literal: true

# class to test role based access controls
class TeamRole < UserRole
  def team
    record
  end

  def role
    team.memberships.find_by(user: user).try(:role)
  end

  def member?
    user && role.present?
  end

  def voter?
    role == "voter"
  end

  def contributor?
    role == "contributor"
  end

  def editor?
    role == "editor"
  end

  def manager?
    role == "manager"
  end

  def visible?
    record.visible?
  end

  def owner?
    record.owner == user
  end
end
