class AddRefNoCashToTransactionbills < ActiveRecord::Migration
  def change
    add_column :transactionbills, :reference_no, :integer
    add_column :transactionbills, :Cash_type, :string
  end
end
