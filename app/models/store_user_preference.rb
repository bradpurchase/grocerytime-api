class StoreUserPreference < ApplicationRecord
  belongs_to :store_user

  before_save :set_default_store, if: :will_save_change_to_default_store?

  def set_default_store
    StoreUserPreference.joins(:store_user)
      .where.not(store_user_preferences: {id: id})
      .where(store_users: {user_id: store_user.user_id})
      .update_all(default_store: false)
  end
end
