class AddAmountToTransactioninvoice < ActiveRecord::Migration
  def change
    add_column :transactioninvoices, :amount, :decimal
  end
end
