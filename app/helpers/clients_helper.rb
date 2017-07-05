module ClientsHelper
  def balance_due_from_clients
    balance = 0.00
    balance_list = Invoice.where("status = ? AND client_id != ?", 'unpaid', 0).pluck(:balance)
    balance_list.collect { |bal| balance += bal.to_f }
    balance
  end
end
