class RankedList < ApplicationRecord
  MIN_NAME_LENGTH = 8
  MAX_NAME_LENGTH = 64
  enum :ranking_method, {
    simple_voting: 0
  }
  belongs_to :team


  # has_many :list_items, dependent: :destroy
  # has_many :votes, dependent: :destroy
  scope :visible, -> { includes(:team).where(team: { visible: true }) }

  validates :name, presence: true, uniqueness: { scope: :team_id }, length: { minimum: 8, maximum: 64 }
  validates :ranking_method, presence: true
  validates :team, presence: true

end

# == Schema Information
#
# Table name: ranked_lists
#
#  id             :bigint           not null, primary key
#  description    :text
#  items_count    :integer          default(0)
#  name           :string
#  ranking_method :integer          default("simple_voting")
#  visible        :boolean          default(TRUE)
#  votes_count    :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  team_id        :bigint           not null
#
# Indexes
#
#  index_ranked_lists_on_name_and_team_id  (name,team_id) UNIQUE
#  index_ranked_lists_on_team_id           (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#
