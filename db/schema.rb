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

ActiveRecord::Schema[7.0].define(version: 2023_11_16_060447) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.boolean "is_protected"
    t.integer "can_access_by", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exchanges", force: :cascade do |t|
    t.float "dolar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "user_with_pendings_actions", null: false
    t.boolean "is_pending", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string "reason"
    t.float "amount"
    t.string "money"
    t.string "method"
    t.string "reference"
    t.string "bank"
    t.string "process_date"
    t.date "payed_at"
    t.bigint "user_id", null: false
    t.boolean "is_accepted"
    t.float "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.string "dni"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "uuid"
    t.integer "base_permissions", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.string "commercial_activity", null: false
    t.bigint "area_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_services_on_area_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "lastname"
    t.string "email"
    t.string "dni"
    t.string "password_digest"
    t.string "gender"
    t.string "uuid"
    t.string "rfid"
    t.string "status"
    t.text "fingerprint"
    t.integer "permissions", default: [], array: true
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "payments", "users"
  add_foreign_key "services", "areas"
  add_foreign_key "users", "roles"
end
