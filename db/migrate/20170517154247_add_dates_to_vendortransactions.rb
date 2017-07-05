class AddDatesToVendortransactions < ActiveRecord::Migration
  def change
    add_column :vendortransactions, :transaction_date, :date
    add_column :vendortransactions, :duedate, :date
  end
end
