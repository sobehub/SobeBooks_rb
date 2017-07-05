# == Schema Information
#
# Table name: clients
#
#  id           :integer          not null, primary key
#  name         :string
#  company_name :string
#  email        :string
#  phone        :string
#  identifier   :string
#  reference    :string
#  notes        :string
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  status       :string
#  setup_id     :integer
#

class Client < ActiveRecord::Base
  validates_presence_of :name, :company_name, :email

  belongs_to :user
  belongs_to :setup

  has_many :invoices,:dependent => :nullify
  has_many :clienttransactions
  include PgSearch
  pg_search_scope :search_clients, :against => [:name, :company_name, :email, :phone, :identifier,
                                                :reference, :notes,:status], :associated_against => {
      :invoices => [:reference]
  }

  STATUSES = ['active', 'inactive', 'past due']

  def statuses
    STATUSES[read_attribute(:statuses)]
  end

  STATUSES.each_with_index do |status, index|
    method_name = status.gsub(" ", "_").underscore
    define_method "#{method_name}!" do
      update_attribute(:statuses, index)
    end

    scope method_name, lambda { where(statuses: index) }
  end

  scope :unclosed, lambda { where.not(statuses: STATUSES[0]) }
  scope :ordered, -> { order("id DESC") }
  scope :order_by_name, -> { order("company_name ASC") }

  PER_PAGE = 10

  def self.search_results(term)
    # Name, Company, email, identified and Ref
    term = term.downcase
    where("lower(name) like ? OR lower(company_name) like ? OR lower(email) like ? OR lower(identifier) like ? OR lower(reference) like ?",
          "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%")
  end

  def current_balance
    balance = 0.00
    invoices.where(status: 'unpaid').each { |invoice| balance += invoice.balance.to_f }
    balance
  end

end
