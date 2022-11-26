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

  def stripped_name
    name.downcase.strip
  end

  def set_category_id
    default_category_id = grocery_trip_category_id_for(DEFAULT_CATEGORY)
    settings = trip.store.category_settings
    return default_category_id if settings.nil?
    category_id = settings.items ? category_id_from_store_settings(settings) : category_id_from_food_classifications_db
    self.category_id = category_id || default_category_id
  end

  def category_id_from_store_settings(settings)
    parsed_json = parse_json_string(settings.items)
    store_category_id = parsed_json[stripped_name]
    store_category_name = StoreCategory.where(id: store_category_id).pick(:name)
    grocery_trip_category_id_for(store_category_name)
  end

  def grocery_trip_category_id_for(store_category_name)
    trip.categories.joins(:store_category).where(store_categories: {name: store_category_name}).pick(:id)
  end

  def category_id_from_food_classifications_db
    category_name = category_name_from_food_classifications_db
    grocery_trip_category_id_for(category_name)
  end

  def category_name_from_food_classifications_db
    parsed_json = parse_json_string(read_food_classification_file)
    food = parsed_json["foods"].find { |f| f["text"] == stripped_name }
    return nil if food.nil?
    food["label"]
  end

  def read_food_classification_file
    File.read("#{Rails.root}/food_classification.json")
  rescue Errno::ENOENT => e
    errors.add(:category_id, :invalid, "Could not read from food classification DB: #{e.message}")
  end

  def parse_json_string(json_str)
    JSON.parse(json_str)
  rescue JSON::ParserError => e
    errors.add(:category_id, :invalid, "Could not parse json: #{e.message}")
  end
end
