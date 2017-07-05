json.array!(@transactioninvoices) do |transactioninvoice|
  json.extract! transactioninvoice, :id, :clienttransaction_id, :invoice_id
  json.url transactioninvoice_url(transactioninvoice, format: :json)
end
