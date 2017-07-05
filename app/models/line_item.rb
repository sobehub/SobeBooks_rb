# == Schema Information
#
# Table name: line_items
#
#  id          :integer          not null, primary key
#  price       :decimal(, )
#  description :string
#  quantity    :integer
#  invoices_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class LineItem < ActiveRecord::Base
  validates_presence_of :price,:description,:quantity

  include Payday::LineItemable
  belongs_to :invoice, :foreign_key => "invoices_id"
end
