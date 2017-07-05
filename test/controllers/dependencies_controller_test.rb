require 'test_helper'

class DependenciesControllerTest < ActionController::TestCase
  setup do
    @dependency = dependencies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dependencies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dependency" do
    assert_difference('Dependency.count') do
      post :create, dependency: { app_id: @dependency.app_id, end_framework: @dependency.end_framework, end_name: @dependency.end_name, end_technology: @dependency.end_technology, end_type: @dependency.end_type, end_version: @dependency.end_version, used_for: @dependency.used_for, which_end: @dependency.which_end }
    end

    assert_redirected_to dependency_path(assigns(:dependency))
  end

  test "should show dependency" do
    get :show, id: @dependency
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dependency
    assert_response :success
  end

  test "should update dependency" do
    patch :update, id: @dependency, dependency: { app_id: @dependency.app_id, end_framework: @dependency.end_framework, end_name: @dependency.end_name, end_technology: @dependency.end_technology, end_type: @dependency.end_type, end_version: @dependency.end_version, used_for: @dependency.used_for, which_end: @dependency.which_end }
    assert_redirected_to dependency_path(assigns(:dependency))
  end

  test "should destroy dependency" do
    assert_difference('Dependency.count', -1) do
      delete :destroy, id: @dependency
    end

    assert_redirected_to dependencies_path
  end
end
