require "test_helper"

class Api::V2::Auth::LoginControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @client = api_clients(:one)
  end

  test "login with valid credentials returns the auth token record" do
    post api_v2_auth_login_path, params: valid_auth_credentials, headers: valid_client_credentials
    json = JSON.parse(response.body)
    assert_not_nil json["access_token"]
    assert_equal @user.id, json["user_id"]
  end

  test "login with invalid credentials returns an error response" do
    post api_v2_auth_login_path, params: invalid_auth_credentials, headers: valid_client_credentials
    json = JSON.parse(response.body)
    assert_not_nil json["error"]
  end

  private

  def valid_auth_credentials
    {
      email: "brad@grocerytime.app",
      password: "password123"
    }
  end

  def invalid_auth_credentials
    {
      email: "foobar@grocerytime.app",
      password: "b0gu$passw0rd"
    }
  end

  def valid_client_credentials
    {
      Authorization: "#{@client.key}:#{@client.secret}"
    }
  end

  
end
