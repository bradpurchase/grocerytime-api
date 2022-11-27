require "test_helper"

class StoreUserPreferenceTest < ActiveSupport::TestCase
  setup do
    @store = stores(:one)
    @store_user = @store.users.first
    @store_user_preferences = @store_user.preferences
  end

  describe "before_save" do
    describe "set_default_store" do
      setup do
        @current_default_store = @store_user.user.default_store
        @store_user_preferences.update!(default_store: true)
      end

      test "updates the user's default store" do
        assert_equal @store, @store_user.reload.user.default_store
      end

      test "unsets the previously default store" do
        assert_not_equal @current_default_store, @store_user.reload.user.default_store
      end
    end
  end
end
