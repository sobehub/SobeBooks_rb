class AddUserIdToTransactioninvoice < ActiveRecord::Migration
  def change
    add_reference :transactioninvoices, :user, index: true, foreign_key: true
  end
end
