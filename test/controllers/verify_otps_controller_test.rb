require "test_helper"

class VerifyOtpsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get verify_otps_index_url
    assert_response :success
  end
end
