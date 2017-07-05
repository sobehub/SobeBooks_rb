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

class Transactionbill < ActiveRecord::Base
  belongs_to :bill
  belongs_to :vendortransaction
end
