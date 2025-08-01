FactoryBot.define do
  factory :membership do
    team { association(:team) }
    user { association(:user) }
    role { "voter" }
  end
  factory :contributor_membership do
    role { "contributor" }
  end
  factory :editor_membership do
    role { "editor" }
  end
  factory :manager_membership do
    role { "manager" }
  end
end

# == Schema Information
#
# Table name: memberships
#
#  id         :bigint           not null, primary key
#  role       :integer          default("voter")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_memberships_on_team_id  (team_id)
#  index_memberships_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#  fk_rails_...  (user_id => users.id)
#
