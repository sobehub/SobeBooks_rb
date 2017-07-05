# == Schema Information
#
# Table name: clienttransactions
#
#  id               :integer          not null, primary key
#  setup_id         :integer
#  client_id        :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  transaction_date :date
#  duedate          :date
#

require 'test_helper'

class ClienttransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
