json.array!(@bills) do |bill|
  json.extract! bill, :id, :reference, :notes, :amount, :lastpaid, :totalpaid, :status, :user_id, :vendor_id
  json.url bill_url(bill, format: :json)
end
