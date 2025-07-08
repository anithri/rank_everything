FactoryBot.define do
  factory :team do
    sequence(:name) { |n| "Title %04d" % n }
    description { "MyText" }
    visible { true }
    owner { association :user }

    factory :invisible_team do
      visible { false }
    end
  end
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
