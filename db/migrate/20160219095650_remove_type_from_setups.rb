class RemoveTypeFromSetups < ActiveRecord::Migration
  def change
    remove_column :setups, :type, :string
  end
end
