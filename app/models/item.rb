# frozen_string_literal: true

class Item < ApplicationRecord
  NAME_REGEX = "^(.*)(\\s)x(\\s?)(\\d+)(\\s+)?"
  DEFAULT_CATEGORY = "Misc."

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
    set_category_id
  end

  private

  def parse_item_name
    match = name.match(NAME_REGEX)
    return if match.nil?
    self.name = match[1]
    self.quantity = match[4]&.to_i
  end

  def set_category_id
    item_name = name.downcase.strip
    settings = trip.store.category_settings.with_item(item_name)
    self.category_id = settings ? category_id_from_store_settings(settings) : category_id_from_food_classifications_db
  end

  def set_category_from_store_settings(settings)
    store_category_id = settings.items[item_name]
    store_category_name = StoreCategory.where(id: store_category_id).pick(:name)
    self.category_id = grocery_trip_category_id_for(store_category_name)
  end

  def grocery_trip_category_id_for(store_category_name)
    trip.categories.joins(:store_category).where(store_categories: {name: store_category_name}).pick(:id)
  end

  def category_id_from_food_classifications_db
    # TODO implement
  end
end
