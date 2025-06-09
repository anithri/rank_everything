class AddAvatarVisibleAndWhoAmI < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :avatar_url, :string
    add_column :users, :visible, :boolean, default: false
    add_column :users, :who_am_i, :text
    add_index :users, :visible
  end
end
