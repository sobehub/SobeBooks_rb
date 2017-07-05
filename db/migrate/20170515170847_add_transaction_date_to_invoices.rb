class AddTransactionDateToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :transaction_date, :date
  end
end
