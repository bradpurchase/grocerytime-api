require "test_helper"

class Api::V2::Auth::IdentityControllerTest < ActionDispatch::IntegrationTest
  setup do
    @auth_token = auth_tokens(:one)
  end

  test "returns user information if valid bearer token is provided" do
    get api_v2_auth_identity_path, headers: valid_bearer_token
    assert_response :ok
    assert_equal @auth_token.user_id, JSON.parse(response.body)["id"]
  end

  private

  def valid_bearer_token
    {
      Authorization: "Bearer #{@auth_token.access_token}"
    }
  end
end
