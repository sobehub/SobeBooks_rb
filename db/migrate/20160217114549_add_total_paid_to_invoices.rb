class AddTotalPaidToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :totalpaid, :decimal
  end
end
