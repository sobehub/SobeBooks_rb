# == Schema Information
#
# Table name: setups
#
#  id          :integer          not null, primary key
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  setuptype   :string
#  typeofsetup :string
#

class Setup < ActiveRecord::Base
  belongs_to :user
  has_many :clients,:dependent => :nullify
  has_many :vendors,:dependent => :nullify
  has_many :clienttransactions
  has_many :vendortransactions
  has_many :bills

  SETUPS = ['client', 'vendor', 'expense','bank']
end
