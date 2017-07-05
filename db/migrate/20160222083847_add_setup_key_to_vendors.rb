class AddSetupKeyToVendors < ActiveRecord::Migration
  def change
    add_reference :vendors, :setup, index: true, foreign_key: true
  end
end
