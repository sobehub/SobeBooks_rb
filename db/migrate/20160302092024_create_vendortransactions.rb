class CreateVendortransactions < ActiveRecord::Migration
  def change
    create_table :vendortransactions do |t|
      t.references :setup, index: true, foreign_key: true
      t.references :vendor, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
