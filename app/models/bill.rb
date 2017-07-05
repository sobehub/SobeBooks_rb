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

class Bill < ActiveRecord::Base
  belongs_to :user
  belongs_to :vendor
  belongs_to :setup
  has_many :transactionbills, dependent: :destroy

  before_save :set_balance

  include PgSearch
  pg_search_scope :search_bills, :against => [:reference,:amount,:status]

  def as_json(options)
    super(:methods => [:balance_amount]).merge(:vendor => vendor.as_json, :transaction_bills => transactionbills.order("id DESC").as_json)
  end

  STATUSES = ['Unpaid','Draft']

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
