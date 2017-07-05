require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { app_count: @product.app_count, last_push: @product.last_push, portfolio_id: @product.portfolio_id, product_name: @product.product_name, repo_count: @product.repo_count, user_id: @product.user_id, visibility: @product.visibility }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: { app_count: @product.app_count, last_push: @product.last_push, portfolio_id: @product.portfolio_id, product_name: @product.product_name, repo_count: @product.repo_count, user_id: @product.user_id, visibility: @product.visibility }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
