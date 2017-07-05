json.array!(@clienttransactions) do |clienttransaction|
  json.extract! clienttransaction, :id, :setup_id, :client_id
  json.url clienttransaction_url(clienttransaction, format: :json)
end
