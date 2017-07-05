class AddVendorTypeToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :vendortype, :string
  end
end
