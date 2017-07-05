class AddFieldsToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :reference, :string
    add_column :invoices, :amount, :decimal
    add_column :invoices, :balance, :decimal
    add_column :invoices, :lastpaid, :decimal
  end
end
