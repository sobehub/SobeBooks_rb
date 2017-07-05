class CreateTransactionbills < ActiveRecord::Migration
  def change
    create_table :transactionbills do |t|
      t.references :bill, index: true, foreign_key: true
      t.references :vendortransaction, index: true, foreign_key: true
      t.decimal :amount
      t.decimal :balance

      t.timestamps null: false
    end
  end
end
