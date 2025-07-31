FactoryBot.define do
  factory :ranked_list do
    sequence(:name) { |n| "MyString %04d" % n }
    description { "MyText" }
    ranking_method { :simple_voting }
    team { association :team }
    visible { false }
    items_count { 0 }
    votes_count { 0 }
  end
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
