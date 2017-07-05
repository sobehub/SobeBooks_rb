class AddClientTypeToClients < ActiveRecord::Migration
  def change
    add_column :clients, :clienttype, :string
  end
end
