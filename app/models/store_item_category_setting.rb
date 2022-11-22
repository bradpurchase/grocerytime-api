class StoreItemCategorySetting < ApplicationRecord
  belongs_to :store

  scope :with_item, ->(name) { find_by("items::jsonb ? '#{name}'") }
end
