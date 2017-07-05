# == Schema Information
#
# Table name: bills
#
#  id               :integer          not null, primary key
#  reference        :string
#  notes            :string
#  amount           :decimal(, )
#  lastpaid         :decimal(, )
#  totalpaid        :decimal(, )
#  status           :string
#  user_id          :integer
#  vendor_id        :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  balance          :decimal(, )
#  lastpayment      :date
#  transaction_date :date
#  duedate          :date
#  setup_id         :integer
#

require 'test_helper'

class BillTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
