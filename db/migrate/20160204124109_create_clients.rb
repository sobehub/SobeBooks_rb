class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :company_name
      t.string :email
      t.string :phone
      t.string :identifier
      t.string :reference
      t.string :notes
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
