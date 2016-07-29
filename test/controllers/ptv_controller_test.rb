require 'test_helper'

class PtvControllerTest < ActionController::TestCase
  test "should get bus" do
    get :bus
    assert_response :success
  end

  test "should get tram" do
    get :tram
    assert_response :success
  end

  test "should get train" do
    get :train
    assert_response :success
  end

end
