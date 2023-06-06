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

ActiveRecord::Schema[7.0].define(version: 2023_06_06_085939) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.float "longitude"
    t.float "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "platform_cities", force: :cascade do |t|
    t.bigint "platform_id", null: false
    t.bigint "city_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_platform_cities_on_city_id"
    t.index ["platform_id"], name: "index_platform_cities_on_platform_id"
  end

  create_table "platforms", force: :cascade do |t|
    t.string "name"
    t.integer "API_endpoint"
    t.float "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rides", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "platform_id", null: false
    t.bigint "city_id", null: false
    t.integer "ETA"
    t.float "fare"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_rides_on_city_id"
    t.index ["platform_id"], name: "index_rides_on_platform_id"
    t.index ["user_id"], name: "index_rides_on_user_id"
  end

  create_table "trips", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ride_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "start_location_id", null: false
    t.bigint "end_location_id", null: false
    t.index ["end_location_id"], name: "index_trips_on_end_location_id"
    t.index ["ride_id"], name: "index_trips_on_ride_id"
    t.index ["start_location_id"], name: "index_trips_on_start_location_id"
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "platform_cities", "cities"
  add_foreign_key "platform_cities", "platforms"
  add_foreign_key "rides", "cities"
  add_foreign_key "rides", "platforms"
  add_foreign_key "rides", "users"
  add_foreign_key "trips", "locations", column: "end_location_id"
  add_foreign_key "trips", "locations", column: "start_location_id"
  add_foreign_key "trips", "rides"
  add_foreign_key "trips", "users"
end
