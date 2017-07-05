json.array!(@vendors) do |vendor|
  json.extract! vendor, :id, :name, :company_name, :email, :phone, :identifier, :reference, :notes, :user_id
  json.url vendor_url(vendor, format: :json)
end
