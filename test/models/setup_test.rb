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

require 'test_helper'

class SetupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
