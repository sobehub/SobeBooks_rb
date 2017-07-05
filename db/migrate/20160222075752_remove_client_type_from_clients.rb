class RemoveClientTypeFromClients < ActiveRecord::Migration
  def change
    remove_column :clients, :clienttype, :string
  end
end
