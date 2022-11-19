class Item < ApplicationRecord
  belongs_to :trip, foreign_key: "grocery_trip_id", class_name: GroceryTrip.to_s

  belongs_to :category, class_name: GroceryTripCategory.to_s
  belongs_to :staple_item, class_name: StoreStapleItem.to_s

  belongs_to :user
  belongs_to :meal

  before_create :set_position

  after_save -> { trip.touch }

  def set_position
    trip.items.where("position >=Man 0").update_all("position = position + 1")
  end

  def touch_grocery_trip
    trip.touch!
  end
end
