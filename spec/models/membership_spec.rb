require 'rails_helper'

RSpec.describe Membership, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:team) }
  end

  describe "validations" do
    subject { build(:membership) }
    it { is_expected.to validate_presence_of(:role) }
  end

  describe "macros" do
    it { is_expected.to define_enum_for(:role).with_values(voter: 0, contributor: 10, editor: 20, manager: 30) }
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
