# == Schema Information
#
# Table name: invoices
#
#  id               :integer          not null, primary key
#  bill_to          :string
#  created_at       :datetime
#  updated_at       :datetime
#  user_id          :integer
#  client_id        :integer
#  reference        :string
#  amount           :decimal(, )
#  balance          :decimal(, )
#  notes            :string
#  lastpayment      :date
#  totalpaid        :decimal(, )
#  status           :string
#  duedate          :date
#  transaction_date :date
#

class Invoice < ActiveRecord::Base
  validates_presence_of :reference, :amount

  belongs_to :user
  belongs_to :client
  has_many :transactioninvoices, dependent: :destroy
  has_many :Clienttransaction, through: :transactioninvoices

  include Payday::Invoiceable

  has_many :line_items, :foreign_key => "invoices_id"

  include PgSearch
  pg_search_scope :search_invoices, :against => [:reference,:amount,:status],:associated_against=> {
      :line_items => [:price,:description,:quantity]
  }

  STATUSES = ['Unpaid','Draft']

  before_save :set_balance

  def as_json(options)
    super(:methods => [:balance_amount]).merge(:client => client.as_json, :transaction_invoices => transactioninvoices.order("id DESC").as_json)
  end
  
  def statuses
    STATUSES[read_attribute(:statuses)]
  end

  def balance_amount
    self.amount.to_f - self.totalpaid.to_f
  end

  def set_balance
    self.balance = balance_amount
  end

  STATUSES.each_with_index do |status, index|
    method_name = status.gsub(" ", "_").underscore
    define_method "#{method_name}!" do
      update_attribute(:statuses, index)
    end

    scope method_name, lambda { where(statuses: index) }
  end

  scope :unclosed, lambda { where.not(statuses: STATUSES[0]) }
end
