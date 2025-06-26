json.extract! team, :id, :name, :description, :visible, :owner_id, :created_at, :updated_at
json.url team_url(team, format: :json)
