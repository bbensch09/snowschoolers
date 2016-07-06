require 'test_helper'

class BetaUsersControllerTest < ActionController::TestCase
  setup do
    @beta_user = beta_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:beta_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create beta_user" do
    assert_difference('BetaUser.count') do
      post :create, beta_user: { email: @beta_user.email, user_type: @beta_user.user_type }
    end

    assert_redirected_to beta_user_path(assigns(:beta_user))
  end

  test "should show beta_user" do
    get :show, id: @beta_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @beta_user
    assert_response :success
  end

  test "should update beta_user" do
    patch :update, id: @beta_user, beta_user: { email: @beta_user.email, user_type: @beta_user.user_type }
    assert_redirected_to beta_user_path(assigns(:beta_user))
  end

  test "should destroy beta_user" do
    assert_difference('BetaUser.count', -1) do
      delete :destroy, id: @beta_user
    end

    assert_redirected_to beta_users_path
  end
end
