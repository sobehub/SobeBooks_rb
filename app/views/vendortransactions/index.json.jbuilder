json.array!(@vendortransactions) do |vendortransaction|
  json.extract! vendortransaction, :id, :setup_id, :vendor_id, :user_id
  json.url vendortransaction_url(vendortransaction, format: :json)
end
