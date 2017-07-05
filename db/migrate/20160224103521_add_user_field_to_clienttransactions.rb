class AddUserFieldToClienttransactions < ActiveRecord::Migration
  def change
    add_reference :clienttransactions, :user, index: true, foreign_key: true
  end
end
