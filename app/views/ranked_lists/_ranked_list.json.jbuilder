json.extract! ranked_list, :id, :name, :description, :ranking_method, :team_id, :visible, :items_count, :votes_count, :created_at, :updated_at
json.url ranked_list_url(ranked_list, format: :json)
