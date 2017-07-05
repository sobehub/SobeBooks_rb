class AddKeyToInvoices < ActiveRecord::Migration
  def change
    add_reference :invoices, :user, index: true, foreign_key: true
    add_reference :invoices, :client, index: true, foreign_key: true
  end
end
