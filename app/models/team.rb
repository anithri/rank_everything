class Team < ApplicationRecord
  MIN_NAME_LENGTH = 8
  MAX_NAME_LENGTH = 64
  belongs_to :owner, class_name: "User"

  scope :visible, -> { where(visible: true) }
end

# == Schema Information
#
# Table name: teams
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  visible     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :bigint           not null
#
# Indexes
#
#  index_teams_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
