class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :reference
      t.string :notes
      t.decimal :amount
      t.decimal :lastpaid
      t.decimal :totalpaid
      t.string :status
      t.references :user, index: true, foreign_key: true
      t.references :vendor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
