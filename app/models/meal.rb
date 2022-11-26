class Meal < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  belongs_to :store

  has_many :users, class_name: MealUser.to_s, dependent: :destroy
  has_many :items, class_name: Item.to_s

  after_destroy :disassociate_items

  def disassociate_items
    items.update_all(meal_id: nil)
  end
end
