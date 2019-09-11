require 'test_helper'

class User::DizziesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_dizzies_create_url
    assert_response :success
  end

  test "should get destroy" do
    get user_dizzies_destroy_url
    assert_response :success
  end

end
