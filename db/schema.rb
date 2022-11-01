# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180724064859) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.string "image"
    t.string "phone_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bank_details", force: :cascade do |t|
    t.bigint "account_number"
    t.string "holder_name"
    t.string "spacial_code"
    t.string "account_type"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bank_details_on_user_id"
  end

  create_table "blogs", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "commissions", force: :cascade do |t|
    t.float "traveller_commission"
    t.float "shipper_commission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pricing_information_id"
    t.string "traveller_commission_type"
    t.boolean "traveller_percentage"
    t.boolean "traveller_fixed"
    t.string "shipper_commission_type"
    t.boolean "shipper_percentage"
    t.boolean "shipper_fixed"
    t.bigint "country_id"
    t.index ["country_id"], name: "index_commissions_on_country_id"
    t.index ["pricing_information_id"], name: "index_commissions_on_pricing_information_id"
  end

  create_table "conditions", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contact_us", force: :cascade do |t|
    t.string "name"
    t.string "reason_for_contacting"
    t.string "message"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contents", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "slug"
    t.string "meta_keyboard"
    t.string "meta_description"
    t.boolean "published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "country_name"
    t.string "iso_code"
    t.float "tax_percentage", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "published", default: false
    t.string "continent"
  end

  create_table "devices", force: :cascade do |t|
    t.string "device_type"
    t.string "device_token"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "disclaimer_policies", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "faqs", force: :cascade do |t|
    t.string "question"
    t.string "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "package_image"
    t.bigint "package_detail_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "imageable_id"
    t.string "imageable_type"
    t.index ["package_detail_id"], name: "index_images_on_package_detail_id"
  end

  create_table "laggage_addresses", force: :cascade do |t|
    t.string "lat"
    t.string "long"
    t.string "address"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "laggages", force: :cascade do |t|
    t.datetime "date"
    t.string "departure_country"
    t.string "departure_state"
    t.string "departure_city"
    t.string "arrival_country"
    t.string "arrival_state"
    t.string "arrival_city"
    t.string "description"
    t.string "value_of_shipment"
    t.bigint "receiver_id"
    t.bigint "traveller_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.float "total_weight"
    t.date "arrival_date"
    t.time "time"
    t.string "mode_of_travel"
    t.boolean "laggage_status", default: false
    t.boolean "traveller_laggage_status", default: false
    t.index ["user_id"], name: "index_laggages_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "location_name"
    t.string "country_code"
    t.string "phone_no"
    t.string "address"
    t.string "state"
    t.string "city"
    t.string "landmark"
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "country"
    t.bigint "country_id"
    t.boolean "publish", default: false
    t.index ["country_id"], name: "index_locations_on_country_id"
  end

  create_table "newsletters", force: :cascade do |t|
    t.string "email"
    t.boolean "is_subscribed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "package_details", force: :cascade do |t|
    t.string "package_content"
    t.string "package_image"
    t.string "size"
    t.bigint "laggage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "weight"
    t.string "weight_unit"
    t.index ["laggage_id"], name: "index_package_details_on_laggage_id"
  end

  create_table "pricing_informations", force: :cascade do |t|
    t.bigint "country_id"
    t.float "weight_from"
    t.string "weight_from_unit"
    t.float "weight_to"
    t.string "weight_to_unit"
    t.float "by_road_price_regional"
    t.float "by_track_price_regional"
    t.float "by_air_price_regional"
    t.float "by_water_price_regional"
    t.float "by_road_price_national"
    t.float "by_track_price_national"
    t.float "by_air_price_national"
    t.float "by_water_price_national"
    t.float "by_road_price_international"
    t.float "by_track_price_international"
    t.float "by_air_price_international"
    t.float "by_water_price_international"
    t.boolean "is_publish", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "country_name"
    t.index ["country_id"], name: "index_pricing_informations_on_country_id"
  end

  create_table "privacies", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "receiver_id"
    t.integer "laggage_id"
    t.integer "star"
    t.boolean "rating_status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receiver_statuses", force: :cascade do |t|
    t.string "receiver_email"
    t.integer "receiver_id"
    t.integer "sender_id"
    t.integer "laggage_id"
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receiving_requests", force: :cascade do |t|
    t.boolean "status", default: false
    t.bigint "laggage_id"
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laggage_id"], name: "index_receiving_requests_on_laggage_id"
  end

  create_table "refund_policies", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sending_requests", force: :cascade do |t|
    t.boolean "status", default: false
    t.bigint "traveller_id"
    t.bigint "sender_id"
    t.bigint "laggage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laggage_id"], name: "index_sending_requests_on_laggage_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "state_name"
    t.string "abbreviation"
    t.boolean "published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "country_id"
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  create_table "timings", force: :cascade do |t|
    t.integer "day"
    t.boolean "is_open", default: false
    t.boolean "published", default: false
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "am_or_pm_open_time"
    t.string "am_or_pm_close_time"
    t.string "open_time"
    t.string "close_time"
    t.index ["location_id"], name: "index_timings_on_location_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.string "email"
    t.float "total_amount", default: 0.0
    t.float "admin_earning_by_traveller", default: 0.0
    t.float "admin_earning_by_shipper", default: 0.0
    t.bigint "laggage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status", default: false
    t.integer "country_id"
    t.text "payment_response"
    t.text "stripe_transaction_id"
    t.float "country_tax"
    t.boolean "refund_status", default: false
    t.index ["laggage_id"], name: "index_transactions_on_laggage_id"
  end

  create_table "traveller_details", force: :cascade do |t|
    t.string "weight_upto"
    t.string "weight_unit"
    t.string "mode_of_travel"
    t.datetime "departure_date"
    t.string "departure_address"
    t.string "departure_country"
    t.string "departure_state"
    t.string "departure_city"
    t.string "departure_zip"
    t.string "departure_meeting_address"
    t.string "departure_meeting_country"
    t.string "departure_meeting_state"
    t.string "departure_meeting_city"
    t.string "departure_meeting_zip"
    t.datetime "arrival_date"
    t.string "arrival_address"
    t.string "arrival_country"
    t.string "arrival_state"
    t.string "arrival_city"
    t.string "arrival_zip"
    t.string "arrival_meeting_address"
    t.string "arrival_meeting_country"
    t.string "arrival_meeting_state"
    t.string "arrival_meeting_city"
    t.string "arrival_meeting_zip"
    t.string "contact_person"
    t.string "contact_phone"
    t.string "contact_country_code"
    t.datetime "last_date_to_recieve_item"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_traveller_details_on_user_id"
  end

  create_table "travellers", force: :cascade do |t|
    t.string "weight_unit"
    t.string "mode_of_travel"
    t.datetime "departure_date"
    t.string "departure_address"
    t.string "departure_country"
    t.string "departure_state"
    t.string "departure_city"
    t.string "departure_zip"
    t.string "departure_meeting_address"
    t.string "departure_meeting_country"
    t.string "departure_meeting_state"
    t.string "departure_meeting_city"
    t.string "departure_meeting_zip"
    t.datetime "arrival_date"
    t.string "arrival_address"
    t.string "arrival_country"
    t.string "arrival_state"
    t.string "arrival_city"
    t.string "arrival_zip"
    t.string "arrival_meeting_address"
    t.string "arrival_meeting_country"
    t.string "arrival_meeting_state"
    t.string "arrival_meeting_city"
    t.string "arrival_meeting_zip"
    t.string "contact_person"
    t.string "contact_phone"
    t.string "contact_country_code"
    t.datetime "last_date_to_recieve_item"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "weight_upto"
    t.time "arrival_time"
    t.time "departure_time"
    t.index ["user_id"], name: "index_travellers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "dob"
    t.string "email"
    t.string "password_digest"
    t.string "phone_no"
    t.string "country_code"
    t.string "address"
    t.string "country"
    t.string "state"
    t.string "city"
    t.string "zip"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "inactive"
    t.boolean "is_block", default: false
    t.boolean "t_and_c", default: false
    t.boolean "email_confirmed", default: false
    t.string "confirm_token"
    t.string "access_token"
  end

  add_foreign_key "bank_details", "users"
  add_foreign_key "commissions", "countries"
  add_foreign_key "commissions", "pricing_informations"
  add_foreign_key "devices", "users"
  add_foreign_key "images", "package_details"
  add_foreign_key "laggages", "users"
  add_foreign_key "locations", "countries"
  add_foreign_key "package_details", "laggages"
  add_foreign_key "pricing_informations", "countries"
  add_foreign_key "receiving_requests", "laggages"
  add_foreign_key "sending_requests", "laggages"
  add_foreign_key "states", "countries"
  add_foreign_key "timings", "locations"
  add_foreign_key "transactions", "laggages"
  add_foreign_key "travellers", "users"
end
