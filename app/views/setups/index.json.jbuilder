json.array!(@setups) do |setup|
  json.extract! setup, :id, :type, :description, :user_id
  json.url setup_url(setup, format: :json)
end
