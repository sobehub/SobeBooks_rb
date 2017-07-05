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

class Clienttransaction < ActiveRecord::Base
  belongs_to :setup
  belongs_to :client
  belongs_to :user
  has_many :transactioninvoices, dependent: :destroy
  has_many :invoices, through: :transactioninvoices
end
