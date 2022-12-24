require "test_helper"

class Api::V2::StoresControllerTest < ActionDispatch::IntegrationTest
  attr_reader :auth_token

  setup do
    @auth_token = auth_tokens(:one)
  end

  describe "#index" do
    test "returns a list of stores" do
      get api_v2_stores_path, headers: {Authorization: "Bearer #{auth_token.access_token}"}
      assert_response :ok
      assert_equal 2, JSON.parse(response.body).size
    end

    test "displays the user's default store at the top of the list" do
      get api_v2_stores_path, headers: {Authorization: "Bearer #{auth_token.access_token}"}
      assert_equal auth_token.user.default_store.id, JSON.parse(response.body)[0]["id"]
    end

    test "stores contain information about store users" do
      get api_v2_stores_path, headers: {Authorization: "Bearer #{auth_token.access_token}"}
      assert_not_nil JSON.parse(response.body)[0]["users"]
      assert_not_nil JSON.parse(response.body)[0]["users"][0]["user"]["id"]
      assert_not_nil JSON.parse(response.body)[0]["users"][0]["user"]["email"]
      assert_not_nil JSON.parse(response.body)[0]["users"][0]["user"]["name"]
    end
  end
end
