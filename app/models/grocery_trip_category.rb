class GroceryTripCategory < ApplicationRecord
  belongs_to :grocery_trip
  belongs_to :store_category

  has_many :items, foreign_key: "category_id"
end
