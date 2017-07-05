class AddDatesToBills < ActiveRecord::Migration
  def change
    add_column :bills, :transaction_date, :date
    add_column :bills, :duedate, :date
  end
end
