class Store < ApplicationRecord
  belongs_to :user

  has_many :trips, class_name: GroceryTrip.to_s

  has_many :categories, class_name: StoreCategory.to_s
  has_one :category_settings, class_name: StoreItemCategorySetting.to_s
end
