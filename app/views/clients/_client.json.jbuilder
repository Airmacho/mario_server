json.extract! client, :id, :name, :age, :private_node, :address, :created_at, :updated_at
json.url client_url(client, format: :json)
