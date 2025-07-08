require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:user) { create(:user) }
  let(:min) { Team::MIN_NAME_LENGTH }
  let(:max) { Team::MAX_NAME_LENGTH }

  describe "associations" do
    it { should belong_to(:owner).class_name("User") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:owner) }
    it { is_expected.to validate_length_of(:name).is_at_least(min).is_at_most(max) }
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
