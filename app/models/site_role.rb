class SiteRole < ApplicationRecord
  enum :role, {
    general: 0,
    guest: 41,
    admin: 42
  }
  belongs_to :user
end

# == Schema Information
#
# Table name: site_roles
#
#  id         :bigint           not null, primary key
#  role       :integer          default("general"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_site_roles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
