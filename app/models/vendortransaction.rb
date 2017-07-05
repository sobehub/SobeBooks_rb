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

class Vendortransaction < ActiveRecord::Base
  belongs_to :setup
  belongs_to :vendor
  belongs_to :user
  has_many :transactionbills, dependent: :destroy
  has_many :bills, through: :transactionbills
end
