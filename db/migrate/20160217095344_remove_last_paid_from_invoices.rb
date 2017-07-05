class RemoveLastPaidFromInvoices < ActiveRecord::Migration
  def change
    remove_column :invoices, :lastpaid, :decimal
  end
end
