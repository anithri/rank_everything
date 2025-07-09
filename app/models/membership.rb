class Membership < ApplicationRecord
  enum :role, { voter: 0, contributor: 10, editor: 20, manager: 30 }
  belongs_to :team
  belongs_to :user

  validates :role, presence: true
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
