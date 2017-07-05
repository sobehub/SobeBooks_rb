require 'test_helper'

class VendortransactionsControllerTest < ActionController::TestCase
  setup do
    @vendortransaction = vendortransactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vendortransactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vendortransaction" do
    assert_difference('Vendortransaction.count') do
      post :create, vendortransaction: { setup_id: @vendortransaction.setup_id, user_id: @vendortransaction.user_id, vendor_id: @vendortransaction.vendor_id }
    end

    assert_redirected_to vendortransaction_path(assigns(:vendortransaction))
  end

  test "should show vendortransaction" do
    get :show, id: @vendortransaction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vendortransaction
    assert_response :success
  end

  test "should update vendortransaction" do
    patch :update, id: @vendortransaction, vendortransaction: { setup_id: @vendortransaction.setup_id, user_id: @vendortransaction.user_id, vendor_id: @vendortransaction.vendor_id }
    assert_redirected_to vendortransaction_path(assigns(:vendortransaction))
  end

  test "should destroy vendortransaction" do
    assert_difference('Vendortransaction.count', -1) do
      delete :destroy, id: @vendortransaction
    end

    assert_redirected_to vendortransactions_path
  end
end
