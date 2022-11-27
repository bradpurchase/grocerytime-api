class User < ApplicationRecord
  has_many :auth_tokens

  has_many :stores

  def default_store
    Store.joins(users: :preferences)
      .where(store_users: {user_id: id})
      .where(store_user_preferences: {default_store: true})
      .last
  end
end
