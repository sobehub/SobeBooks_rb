class CreateTransactioninvoices < ActiveRecord::Migration
  def change
    create_table :transactioninvoices do |t|
      t.references :clienttransaction, index: true, foreign_key: true
      t.references :invoice, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
