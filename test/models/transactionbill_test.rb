# == Schema Information
#
# Table name: transactionbills
#
#  id                   :integer          not null, primary key
#  bill_id              :integer
#  vendortransaction_id :integer
#  amount               :decimal(, )
#  balance              :decimal(, )
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  reference_no         :integer
#  Cash_type            :string
#

require 'test_helper'

class TransactionbillTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
