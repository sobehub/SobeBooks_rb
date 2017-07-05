module ReportsHelper
  def total_payment(client_transactions)
    total_payment = 0.0
    client_transactions.each do |ct|
      total_payment += ct.transactioninvoices.map { |t| t.amount.to_f }.compact.sum
    end
    total_payment
  end

  def total_payment_vendor(vendor_transactions)
    total_payment = 0.0
    vendor_transactions.each do |vt|
      total_payment += vt.transactionbills.map { |t| t.amount.to_f }.compact.sum
    end
    total_payment
  end
end
