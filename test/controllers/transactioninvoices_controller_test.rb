require 'test_helper'

class TransactioninvoicesControllerTest < ActionController::TestCase
  setup do
    @transactioninvoice = transactioninvoices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transactioninvoices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transactioninvoice" do
    assert_difference('Transactioninvoice.count') do
      post :create, transactioninvoice: { clienttransaction_id: @transactioninvoice.clienttransaction_id, invoice_id: @transactioninvoice.invoice_id }
    end

    assert_redirected_to transactioninvoice_path(assigns(:transactioninvoice))
  end

  test "should show transactioninvoice" do
    get :show, id: @transactioninvoice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @transactioninvoice
    assert_response :success
  end

  test "should update transactioninvoice" do
    patch :update, id: @transactioninvoice, transactioninvoice: { clienttransaction_id: @transactioninvoice.clienttransaction_id, invoice_id: @transactioninvoice.invoice_id }
    assert_redirected_to transactioninvoice_path(assigns(:transactioninvoice))
  end

  test "should destroy transactioninvoice" do
    assert_difference('Transactioninvoice.count', -1) do
      delete :destroy, id: @transactioninvoice
    end

    assert_redirected_to transactioninvoices_path
  end
end
