class AddBalanceToTransactioninvoices < ActiveRecord::Migration
  def change
    add_column :transactioninvoices, :balance, :decimal
  end
end
