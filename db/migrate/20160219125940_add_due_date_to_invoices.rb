class AddDueDateToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :duedate, :date
  end
end
