require "test_helper"

class ResponseControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get response_new_url
    assert_response :success
  end
end
