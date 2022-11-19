# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_11_19_212601) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "api_clients", id: :uuid, default: -> { "public.gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "key", limit: 100, null: false
    t.string "secret", limit: 100, null: false
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.index ["name"], name: "uix_api_clients_name", unique: true
  end

  create_table "auth_tokens", id: :uuid, default: -> { "public.gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "client_id", default: -> { "public.gen_random_uuid()" }, null: false
    t.uuid "user_id", default: -> { "public.gen_random_uuid()" }, null: false
    t.string "access_token", limit: 100, null: false
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.string "device_name", limit: 100
    t.index ["access_token"], name: "idx_auth_tokens_access_token"
  end

  create_table "devices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "token", limit: 255, null: false
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.timestamptz "deleted_at"
  end

  create_table "grocery_trip_categories", id: :uuid, default: -> { "public.gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "grocery_trip_id", null: false
    t.uuid "store_category_id", null: false
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.timestamptz "deleted_at"
    t.index ["grocery_trip_id"], name: "idx_grocery_trip_categories_grocery_trip_id"
    t.index ["store_category_id"], name: "idx_grocery_trip_categories_store_category_id"
  end

  create_table "grocery_trips", id: :uuid, default: -> { "public.gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.string "name", limit: 100, null: false
    t.boolean "completed", default: false, null: false
    t.boolean "copy_remaining_items", default: false, null: false
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.timestamptz "deleted_at"
    t.index ["store_id"], name: "idx_grocery_trips_store_id"
  end

  create_table "items", id: :uuid, default: -> { "public.gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "grocery_trip_id", null: false
    t.uuid "category_id", null: false
    t.uuid "user_id", null: false
    t.string "name", limit: 100, null: false
    t.integer "quantity", default: 1, null: false
    t.boolean "completed", default: false, null: false
    t.integer "position", default: 1, null: false
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.timestamptz "deleted_at"
    t.uuid "meal_id"
    t.string "notes", limit: 255
    t.string "meal_name", limit: 255
    t.uuid "staple_item_id"
    t.index ["grocery_trip_id", "category_id"], name: "idx_items_grocery_trip_id_category_id"
    t.index ["grocery_trip_id"], name: "idx_items_grocery_trip_id"
    t.index ["name", "grocery_trip_id"], name: "idx_items_name_grocery_trip_id"
    t.index ["staple_item_id"], name: "idx_items_staple_item_id"
  end

  create_table "meal_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "meal_id", null: false
    t.uuid "user_id", null: false
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.timestamptz "deleted_at"
    t.index ["user_id"], name: "idx_meal_users_user_id"
  end

  create_table "meals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "recipe_id", null: false
    t.uuid "user_id", null: false
    t.string "name", limit: 255, null: false
    t.string "meal_type", limit: 10, null: false
    t.bigint "servings", default: 1, null: false
    t.text "notes"
    t.string "date", limit: 255, null: false
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.timestamptz "deleted_at"
    t.uuid "store_id", null: false
    t.index ["date"], name: "idx_meals_date"
    t.index ["name"], name: "idx_meals_name"
  end

  create_table "migrations", id: { type: :string, limit: 255 }, force: :cascade do |t|
  end

  create_table "recipe_ingredients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "recipe_id", null: false
    t.string "name", limit: 255, null: false
    t.string "amount", limit: 255
    t.string "unit", limit: 20
    t.string "notes", limit: 255
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.timestamptz "deleted_at"
    t.index ["recipe_id"], name: "idx_recipe_ingredients_recipe_id"
  end

  create_table "recipes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "name", limit: 255, null: false
    t.string "url", limit: 255
    t.string "meal_type", limit: 10, null: false
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.timestamptz "deleted_at"
    t.text "description"
    t.text "image_url"
    t.jsonb "instructions"
    t.index ["name"], name: "idx_recipes_name"
    t.index ["user_id"], name: "idx_recipes_user_id"
  end

  create_table "store_categories", id: :uuid, default: -> { "public.gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.string "name", limit: 100, null: false
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.timestamptz "deleted_at"
    t.index ["store_id"], name: "idx_store_categories_store_id"
  end

  create_table "store_item_category_settings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.jsonb "items"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.timestamptz "deleted_at"
    t.index ["store_id"], name: "idx_store_category_items_store_id"
  end

  create_table "store_staple_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.string "name", limit: 100, null: false
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.timestamptz "deleted_at"
    t.index ["store_id", "name"], name: "idx_store_staple_items_store_id_name"
    t.index ["store_id"], name: "idx_store_staple_items_store_id"
  end

  create_table "store_user_preferences", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_user_id", null: false
    t.boolean "default_store", default: false, null: false
    t.boolean "notifications", default: true, null: false
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.timestamptz "deleted_at"
    t.index ["store_user_id"], name: "idx_store_user_preferences_store_user_id", unique: true
  end

  create_table "store_users", id: :uuid, default: -> { "public.gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "user_id"
    t.string "email", limit: 100
    t.boolean "creator", default: false, null: false
    t.boolean "active", default: true, null: false
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.timestamptz "deleted_at"
    t.boolean "default_store", default: false, null: false
    t.index ["store_id", "user_id"], name: "idx_store_users_store_id_user_id"
    t.index ["store_id"], name: "idx_store_users_store_id"
    t.index ["user_id"], name: "idx_store_users_user_id"
  end

  create_table "stores", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", default: -> { "gen_random_uuid()" }, null: false
    t.string "name", limit: 100, null: false
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.timestamptz "deleted_at"
    t.string "share_code", limit: 255
    t.index ["share_code"], name: "idx_stores_share_code", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", limit: 100, null: false
    t.text "password", null: false
    t.string "name", limit: 100
    t.timestamptz "last_seen_at"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.uuid "password_reset_token"
    t.timestamptz "password_reset_token_expiry"
    t.string "siwa_id", limit: 255
    t.index ["email"], name: "uix_users_email", unique: true
    t.index ["siwa_id"], name: "idx_users_siwa_id", unique: true
  end

  add_foreign_key "stores", "users", name: "fk_users_stores"
end
