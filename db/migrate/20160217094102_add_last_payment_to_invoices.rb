class AddLastPaymentToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :lastpayment, :date
  end
end
