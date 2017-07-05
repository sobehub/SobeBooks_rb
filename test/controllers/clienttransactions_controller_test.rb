require 'test_helper'

class ClienttransactionsControllerTest < ActionController::TestCase
  setup do
    @clienttransaction = clienttransactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clienttransactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create clienttransaction" do
    assert_difference('Clienttransaction.count') do
      post :create, clienttransaction: { client_id: @clienttransaction.client_id, setup_id: @clienttransaction.setup_id }
    end

    assert_redirected_to clienttransaction_path(assigns(:clienttransaction))
  end

  test "should show clienttransaction" do
    get :show, id: @clienttransaction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @clienttransaction
    assert_response :success
  end

  test "should update clienttransaction" do
    patch :update, id: @clienttransaction, clienttransaction: { client_id: @clienttransaction.client_id, setup_id: @clienttransaction.setup_id }
    assert_redirected_to clienttransaction_path(assigns(:clienttransaction))
  end

  test "should destroy clienttransaction" do
    assert_difference('Clienttransaction.count', -1) do
      delete :destroy, id: @clienttransaction
    end

    assert_redirected_to clienttransactions_path
  end
end
