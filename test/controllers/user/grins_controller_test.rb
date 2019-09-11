require 'test_helper'

class User::GrinsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_grins_create_url
    assert_response :success
  end

  test "should get destroy" do
    get user_grins_destroy_url
    assert_response :success
  end

end
