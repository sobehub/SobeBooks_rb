module VendorsHelper
  def owed_to_vendors
    balance = 0.00
    balance_list = Bill.where("status = ? AND vendor_id != ?", 'unpaid', 0).pluck(:balance)
    balance_list.collect { |bal| balance += bal.to_f }
    balance
  end
end
