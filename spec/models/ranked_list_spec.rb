require 'rails_helper'

RSpec.describe RankedList, type: :model do
  let(:min) { RankedList::MIN_NAME_LENGTH }
  let(:max) { RankedList::MAX_NAME_LENGTH }

  describe "associations" do
    it { is_expected.to belong_to(:team) }
  end

  describe "validations" do
    subject { create(:ranked_list) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:ranking_method) }
    it { is_expected.to validate_length_of(:name).is_at_least(min).is_at_most(max) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:team_id) }
  end

  describe "macros" do
    it { is_expected.to define_enum_for(:ranking_method).with_values(simple_voting: 0) }
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
