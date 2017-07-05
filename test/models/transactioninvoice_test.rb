# == Schema Information
#
# Table name: transactioninvoices
#
#  id                   :integer          not null, primary key
#  clienttransaction_id :integer
#  invoice_id           :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  balance              :decimal(, )
#  amount               :decimal(, )
#  reference_no         :integer
#  Cash_type            :string
#  user_id              :integer
#

require 'test_helper'

class TransactioninvoiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
