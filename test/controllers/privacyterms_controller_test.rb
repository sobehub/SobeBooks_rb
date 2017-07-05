require 'test_helper'

class PrivacytermsControllerTest < ActionController::TestCase
  test "should get privacy" do
    get :privacy
    assert_response :success
  end

  test "should get conditions" do
    get :conditions
    assert_response :success
  end

end
