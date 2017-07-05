json.array!(@transactionbills) do |transactionbill|
  json.extract! transactionbill, :id, :bill_id, :vendortransaction_id, :amount, :balance
  json.url transactionbill_url(transactionbill, format: :json)
end
