require "test_helper"

class ItemTest < ActiveSupport::TestCase
  attr_reader :trip, :user, :category

  setup do
    @trip = grocery_trips(:one)
    @user = @trip.items.first.user
    @category = @trip.items.first.category
  end

  let(:item_name) { "Apples" }
  let(:quantity) { 1 }
  let!(:item) do
    trip.items.create!(user: user, category: category, name: item_name, quantity: quantity)
  end

  describe "before_create" do
    test "sets the item's position" do
      assert_equal 1, item.reload.position
    end
  end

  describe "before_save" do
    describe "parse_item_name" do
      test "parses an item name with no embedded quantity" do
        assert_equal item_name, item.name
        assert_equal 1, item.quantity
      end

      describe "quantity embedded in item name" do
        let(:item_name) { "Egg Whites x 2" }
        let!(:item) do
          trip.items.create!(user: user, category: category, name: item_name)
        end

        test "correctly parses an item name with embedded quantity" do
          assert_equal "Egg Whites", item.name
          assert_equal 2, item.quantity
        end
      end
    end
  end
end
