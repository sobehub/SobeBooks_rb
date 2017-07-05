# == Schema Information
#
# Table name: vendortransactions
#
#  id               :integer          not null, primary key
#  setup_id         :integer
#  vendor_id        :integer
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  transaction_date :date
#  duedate          :date
#

require 'test_helper'

class VendortransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
