class CreateSetups < ActiveRecord::Migration
  def change
    create_table :setups do |t|
      t.string :type
      t.text :description
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
