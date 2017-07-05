class AddDatesToClienttransactions < ActiveRecord::Migration
  def change
    add_column :clienttransactions, :transaction_date, :date
    add_column :clienttransactions, :duedate, :date
  end
end
