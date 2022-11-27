class StoreUser < ApplicationRecord
  belongs_to :store
  belongs_to :user

  has_one :preferences, class_name: StoreUserPreference.to_s
end
