require 'test_helper'

class TransactionbillsControllerTest < ActionController::TestCase
  setup do
    @transactionbill = transactionbills(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transactionbills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transactionbill" do
    assert_difference('Transactionbill.count') do
      post :create, transactionbill: { amount: @transactionbill.amount, balance: @transactionbill.balance, bill_id: @transactionbill.bill_id, vendortransaction_id: @transactionbill.vendortransaction_id }
    end

    assert_redirected_to transactionbill_path(assigns(:transactionbill))
  end

  test "should show transactionbill" do
    get :show, id: @transactionbill
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @transactionbill
    assert_response :success
  end

  test "should update transactionbill" do
    patch :update, id: @transactionbill, transactionbill: { amount: @transactionbill.amount, balance: @transactionbill.balance, bill_id: @transactionbill.bill_id, vendortransaction_id: @transactionbill.vendortransaction_id }
    assert_redirected_to transactionbill_path(assigns(:transactionbill))
  end

  test "should destroy transactionbill" do
    assert_difference('Transactionbill.count', -1) do
      delete :destroy, id: @transactionbill
    end

    assert_redirected_to transactionbills_path
  end
end
