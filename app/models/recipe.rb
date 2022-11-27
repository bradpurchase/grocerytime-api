class Recipe < ApplicationRecord
  belongs_to :user

  has_many :ingredients, class_name: RecipeIngredient.to_s
  has_many :meals
end
