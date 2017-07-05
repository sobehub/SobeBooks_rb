class AddSetupIdToBills < ActiveRecord::Migration
  def change
    add_column :bills, :setup_id, :integer
  end
end
