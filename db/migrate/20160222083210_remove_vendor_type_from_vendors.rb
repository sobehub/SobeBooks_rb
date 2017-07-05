class RemoveVendorTypeFromVendors < ActiveRecord::Migration
  def change
    remove_column :vendors, :vendortype, :string
  end
end
