class AddSetupTypeFieldToSetups < ActiveRecord::Migration
  def change
    add_column :setups, :setuptype, :string
  end
end
