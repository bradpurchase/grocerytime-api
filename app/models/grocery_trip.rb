class GroceryTrip < ApplicationRecord
  belongs_to :store

  has_many :items

  before_create :set_trip_name

  def set_trip_name
    dupe_trip_count = GroceryTrip.where("name LIKE ?", "%#{name}%").where(store_id: store_id).size
    self.name += "(#{dupe_trip_count + 1})" unless dupe_trip_count.zero?
  end
end
