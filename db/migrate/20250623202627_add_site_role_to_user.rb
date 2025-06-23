class AddSiteRoleToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :site_role, :integer, default: 0
  end
end
