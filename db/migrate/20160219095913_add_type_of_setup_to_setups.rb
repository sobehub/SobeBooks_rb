class AddTypeOfSetupToSetups < ActiveRecord::Migration
  def change
    add_column :setups, :typeofsetup, :string
  end
end
