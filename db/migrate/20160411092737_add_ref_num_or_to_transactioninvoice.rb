class AddRefNumOrToTransactioninvoice < ActiveRecord::Migration
  def change
    add_column :transactioninvoices, :reference_no, :integer
    add_column :transactioninvoices, :Cash_type, :string
  end
end
