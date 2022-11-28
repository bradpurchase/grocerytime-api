require "test_helper"

class Api::V2::LoginControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @client = api_clients(:one)
  end

  test "login with valid credentials returns the auth token record" do
    post api_v2_login_index_path, params: valid_auth_credentials, headers: valid_client_credentials
    res = JSON.parse(response.body)
    assert_not_nil res["access_token"]
    assert_equal @user.id, res["user_id"]
  end

  private

  def valid_auth_credentials
    {
      email: "brad@grocerytime.app",
      password: "password123"
    }
  end

  def valid_client_credentials
    {
      Authorization: "#{@client.key}:#{@client.secret}"
    }
  end
end
