class Item < ApplicationRecord
  NAME_REGEX = "^(.*)(\\s)x(\\s?)(\\d+)(\\s+)?"

  belongs_to :trip, foreign_key: "grocery_trip_id", class_name: GroceryTrip.to_s

  belongs_to :category, class_name: GroceryTripCategory.to_s
  belongs_to :staple_item, class_name: StoreStapleItem.to_s, optional: true

  belongs_to :user
  belongs_to :meal, optional: true

  before_create :set_position
  before_save :set_metadata

  def set_position
    trip.items.where("position >= 0").update_all("position = position + 1")
  end

  def set_metadata
    parse_item_name
  end

  private

  def parse_item_name
    match = name.match(NAME_REGEX)
    return name if match.nil?
    self.name = match[1]
    self.quantity = match[4]&.to_i
  end
end
