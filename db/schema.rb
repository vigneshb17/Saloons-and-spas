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

ActiveRecord::Schema.define(version: 2021_10_19_135202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.time "from_time"
    t.time "to_time"
    t.date "booking_date"
    t.integer "status"
    t.bigint "customer_id"
    t.bigint "saloon_id"
    t.bigint "chair_id"
    t.bigint "service_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chair_id"], name: "index_bookings_on_chair_id"
    t.index ["customer_id"], name: "index_bookings_on_customer_id"
    t.index ["saloon_id"], name: "index_bookings_on_saloon_id"
    t.index ["service_id"], name: "index_bookings_on_service_id"
  end

  create_table "chairs", force: :cascade do |t|
    t.boolean "available"
    t.bigint "saloon_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["saloon_id"], name: "index_chairs_on_saloon_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "saloons", force: :cascade do |t|
    t.string "company_name"
    t.string "address"
    t.string "GSTIN"
    t.string "pan_number"
    t.integer "total_chairs_count"
    t.integer "available_chairs_count"
    t.time "working_hours_from"
    t.time "working_hours_to"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "services", force: :cascade do |t|
    t.integer "service_type"
    t.integer "timings_in_mins"
    t.integer "price"
    t.bigint "saloon_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["saloon_id"], name: "index_services_on_saloon_id"
  end

end
