class CreateClienttransactions < ActiveRecord::Migration
  def change
    create_table :clienttransactions do |t|
      t.references :setup, index: true, foreign_key: true
      t.references :client, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
