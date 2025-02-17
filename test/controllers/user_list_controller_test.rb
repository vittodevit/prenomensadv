require "test_helper"

class UserListControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_list_index_url
    assert_response :success
  end
end
