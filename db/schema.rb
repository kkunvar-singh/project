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

ActiveRecord::Schema[7.0].define(version: 2023_06_03_125617) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "addresses", id: :uuid, default: nil, force: :cascade do |t|
    t.string "parmanent_address"
    t.string "residencial_address"
    t.string "city"
    t.string "state"
    t.string "country"
    t.integer "pin"
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "users", id: :uuid, default: nil, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "mobail_number"
    t.string "email"
    t.string "date_of_birth"
    t.integer "activated"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "otp"
    t.datetime "otp_send_at"
    t.integer "type_otp"
  end

  add_foreign_key "addresses", "users"
end
