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

ActiveRecord::Schema.define(version: 20171211032848) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "restaurants", force: :cascade do |t|
    t.string  "name"
    t.string  "category"
    t.string  "profile_photo"
    t.string  "location"
    t.string  "phone_number"
    t.string  "address"
    t.date    "opening_time"
    t.date    "closing_time"
    t.integer "rating"
    t.integer "price_per_person"
    t.float   "lat"
    t.float   "lng"
    t.integer "dianping_id"
    t.string  "dianping_url"
    t.float   "rating_flavor"
    t.float   "rating_environ"
    t.float   "rating_service"
  end

  create_table "sessions", force: :cascade do |t|
    t.string  "session_uuid"
    t.integer "user_id"
    t.float   "lat"
    t.float   "lng"
    t.index ["user_id"], name: "index_sessions_on_user_id", using: :btree
  end

  create_table "shakes", force: :cascade do |t|
    t.integer  "session_id"
    t.integer  "restaurant_id"
    t.json     "parameters"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["restaurant_id"], name: "index_shakes_on_restaurant_id", using: :btree
    t.index ["session_id"], name: "index_shakes_on_session_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "authentication_token",   limit: 30
    t.string   "uuid"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
