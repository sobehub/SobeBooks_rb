require 'test_helper'

class HostingsControllerTest < ActionController::TestCase
  setup do
    @hosting = hostings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hostings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hosting" do
    assert_difference('Hosting.count') do
      post :create, hosting: { account_login: @hosting.account_login, account_type: @hosting.account_type, app_id: @hosting.app_id, password: @hosting.password, provider: @hosting.provider }
    end

    assert_redirected_to hosting_path(assigns(:hosting))
  end

  test "should show hosting" do
    get :show, id: @hosting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hosting
    assert_response :success
  end

  test "should update hosting" do
    patch :update, id: @hosting, hosting: { account_login: @hosting.account_login, account_type: @hosting.account_type, app_id: @hosting.app_id, password: @hosting.password, provider: @hosting.provider }
    assert_redirected_to hosting_path(assigns(:hosting))
  end

  test "should destroy hosting" do
    assert_difference('Hosting.count', -1) do
      delete :destroy, id: @hosting
    end

    assert_redirected_to hostings_path
  end
end
