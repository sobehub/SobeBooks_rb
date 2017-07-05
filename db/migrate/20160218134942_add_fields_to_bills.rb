class AddFieldsToBills < ActiveRecord::Migration
  def change
    add_column :bills, :balance, :decimal
    add_column :bills, :lastpayment, :date
  end
end
