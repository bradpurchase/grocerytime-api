class Meal < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  belongs_to :store
end
