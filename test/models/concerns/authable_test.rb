require "test_helper"

class ApiClientTest < ActiveSupport::TestCase
  describe "valid_credentials" do
    test "returns user if credentials are valid" do
      assert_equal users(:one), User.valid_credentials("brad@grocerytime.app", "password123")
    end

    test "returns nil if credentials are invalid" do
      assert_nil User.valid_credentials("fake@grocerytime.app", "password")
    end
  end
end
