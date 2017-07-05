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

class Transactioninvoice < ActiveRecord::Base
  belongs_to :clienttransaction
  belongs_to :invoice
  belongs_to :user
end
