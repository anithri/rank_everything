class CreateRankedLists < ActiveRecord::Migration[8.0]
  def change
    create_table :ranked_lists do |t|
      t.string :name
      t.text :description
      t.integer :ranking_method, default: 0
      t.references :team, null: false, foreign_key: true
      t.boolean :visible, default: true
      t.integer :ranked_items_count, default: 0
      t.integer :votes_count, default: 0

      t.timestamps
    end

    add_index :ranked_lists, [ :name, :team_id ], unique: true
  end
end
