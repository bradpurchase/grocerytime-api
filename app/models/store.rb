class Store < ApplicationRecord
  belongs_to :user

  has_many :users, class_name: StoreUser.to_s, dependent: :destroy

  has_many :trips, class_name: GroceryTrip.to_s, dependent: :destroy

  has_many :categories, class_name: StoreCategory.to_s, dependent: :destroy
  has_one :category_settings, class_name: StoreItemCategorySetting.to_s, dependent: :destroy

  validates :share_code, uniqueness: true

  before_save :generate_share_code

  after_destroy :notify_store_users

  def generate_share_code
    self.share_code = SecureRandom.base58(6).upcase
  end

  def notify_store_users
    # TODO: implement email
  end
end
