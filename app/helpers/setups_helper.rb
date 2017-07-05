module SetupsHelper
  def bank_balance
    (Transactioninvoice.all.collect {|ti| ti.amount}.compact.sum.to_f - Transactionbill.all.collect {|tb| tb.amount}.compact.sum)
  end
end
