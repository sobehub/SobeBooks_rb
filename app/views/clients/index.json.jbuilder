json.array!(@clients) do |client|
  json.extract! client, :id, :name, :company_name, :email, :phone, :identifier, :reference, :notes, :user_id
  json.url client_url(client, format: :json)
end
