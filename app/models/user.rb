class User < ApplicationRecord
  include Authable

  has_many :auth_tokens, dependent: :destroy
  has_many :devices, dependent: :destroy

  has_many :stores, dependent: :destroy
  has_many :store_users, dependent: :destroy

  has_many :meals, dependent: :destroy
  has_many :recipes, dependent: :destroy

  def default_store
    Store.joins(users: :preferences)
      .where(store_users: {user_id: id})
      .where(store_user_preferences: {default_store: true})
      .last
  end
end
