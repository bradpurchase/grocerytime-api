require "test_helper"

class ItemTest < ActiveSupport::TestCase
  setup do
    @trip = grocery_trips(:one)
    @user = @trip.items.first.user
    @category = @trip.items.first.category
    @item = @trip.items.create!(user: @user, category: @category, name: "Apples", quantity: 1)
  end

  describe "before_create" do
    test "sets the position position" do
      assert_equal 1, @item.reload.position
    end
  end

  describe "after_create" do
    test "updates the trip's updated_at timestamp" do
      assert_equal Time.now.to_i, @item.reload.trip.updated_at.to_i
    end
  end
end
