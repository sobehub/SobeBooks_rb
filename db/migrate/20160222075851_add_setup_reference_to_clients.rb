class AddSetupReferenceToClients < ActiveRecord::Migration
  def change
    add_reference :clients, :setup, index: true, foreign_key: true
  end
end
