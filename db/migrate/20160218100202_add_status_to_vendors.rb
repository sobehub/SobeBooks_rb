class AddStatusToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :status, :string
  end
end
