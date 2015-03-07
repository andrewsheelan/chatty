require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get presence" do
    get :presence
    assert_response :success
  end

  test "should get presence_auth" do
    get :presence_auth
    assert_response :success
  end

end
