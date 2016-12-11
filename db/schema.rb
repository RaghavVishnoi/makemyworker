# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 201512280435904) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "gig_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buyer_accounts", force: :cascade do |t|
    t.integer  "user_id",                        null: false
    t.string   "status",      default: "Active", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "customer_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "charges", force: :cascade do |t|
    t.integer  "request_id",                          null: false
    t.string   "amount",                              null: false
    t.integer  "user_id",                             null: false
    t.integer  "buyer_account_id",                    null: false
    t.string   "status",           default: "Active", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",           null: false
    t.float    "lat",            null: false
    t.float    "lng",            null: false
    t.string   "time_zone_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_url"
  end

  create_table "cities_wants", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "credits", force: :cascade do |t|
    t.string   "counts"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices", force: :cascade do |t|
    t.integer "user_id"
    t.string  "device_type"
    t.text    "installation_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id",                  null: false
    t.integer  "friend_id",                null: false
    t.integer  "initiated_by",             null: false
    t.integer  "deleted_by"
    t.integer  "status",       default: 1, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "deleted_at"
  end

  create_table "gig_likes", force: :cascade do |t|
    t.integer "gig_id",  null: false
    t.integer "user_id", null: false
  end

  create_table "gig_neighborhood_associations", force: :cascade do |t|
    t.integer  "gig_id"
    t.integer  "neighborhood_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gigs", force: :cascade do |t|
    t.string   "title",                       null: false
    t.text     "description"
    t.string   "price",                       null: false
    t.integer  "user_id",                     null: false
    t.string   "friends_only"
    t.string   "token",                       null: false
    t.string   "sponsored"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.boolean  "is_active",    default: true
    t.integer  "category_id"
    t.boolean  "featured"
  end

  create_table "images", force: :cascade do |t|
    t.string   "image"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "issues", force: :cascade do |t|
    t.integer "request_id",  null: false
    t.integer "sender_id",   null: false
    t.string  "description"
  end

  create_table "locations", force: :cascade do |t|
    t.float   "lat"
    t.float   "lng"
    t.integer "radius"
    t.integer "gig_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "request_id",   null: false
    t.integer  "user_id",      null: false
    t.text     "content"
    t.integer  "message_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "user_type"
    t.integer  "seen"
  end

  create_table "models", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
  end

  create_table "my_promo_codes", force: :cascade do |t|
    t.integer  "promo_code_id",                    null: false
    t.integer  "user_id",                          null: false
    t.datetime "added_on",                         null: false
    t.integer  "status",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
    t.boolean  "is_referral_code", default: false
  end

  create_table "neighborhoods", force: :cascade do |t|
    t.string   "name",                        null: false
    t.integer  "city_id",                     null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.float    "lat",                         null: false
    t.float    "lng",                         null: false
    t.boolean  "entire_city", default: false
  end

  create_table "promo_codes", force: :cascade do |t|
    t.string   "code"
    t.string   "amount"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "amount_type"
    t.boolean  "all_users"
    t.datetime "expire_on"
    t.integer  "status"
  end

  create_table "recent_activities", force: :cascade do |t|
    t.string   "message"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sender_id"
  end

  create_table "referral_codes", force: :cascade do |t|
    t.string   "code",       null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "gig_id",                    null: false
    t.integer  "seller_id",                 null: false
    t.integer  "buyer_id",                  null: false
    t.integer  "message_count"
    t.integer  "status",                    null: false
    t.boolean  "flagged",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "seen",          default: 0
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating",      null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "request_id"
    t.integer  "user_id"
  end

  create_table "seller_accounts", force: :cascade do |t|
    t.integer  "user_id",                         null: false
    t.string   "status",       default: "Active", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "recipient_id"
  end

  create_table "used_referral_codes", force: :cascade do |t|
    t.integer  "referral_code_id", null: false
    t.integer  "user_id",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                                                             null: false
    t.string   "last_name",                                                              null: false
    t.string   "email"
    t.string   "username"
    t.string   "photo_url"
    t.string   "facebook_user_id"
    t.string   "facebook_user_token"
    t.string   "token",                                                                  null: false
    t.date     "birthday"
    t.string   "gender"
    t.text     "bio"
    t.string   "last_known_location"
    t.string   "time_zone_name",                  default: "Eastern Time (US & Canada)"
    t.integer  "user_type",                       default: 0,                            null: false
    t.integer  "is_admin",                        default: 0,                            null: false
    t.datetime "deleted_at"
    t.integer  "status",                          default: 1,                            null: false
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
    t.integer  "city_id"
    t.boolean  "is_seller"
    t.boolean  "bgcheck_verified",                default: false
    t.string   "encrypted_password",  limit: 128
    t.string   "confirmation_token",  limit: 128
    t.string   "remember_token",      limit: 128
    t.boolean  "logged_in"
    t.boolean  "bgcheck_approved",                default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["facebook_user_id"], name: "index_users_on_facebook_user_id", unique: true, using: :btree
  add_index "users", ["facebook_user_token"], name: "index_users_on_facebook_user_token", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree
  add_index "users", ["token"], name: "index_users_on_token", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name",                              null: false
    t.string   "address",                           null: false
    t.string   "main_picture_url"
    t.string   "thumbnail_picture_url"
    t.string   "location_id",                       null: false
    t.string   "category_names",                    null: false
    t.float    "lat"
    t.float    "lng"
    t.string   "token",                             null: false
    t.integer  "status",                default: 1, null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "venues", ["location_id"], name: "index_venues_on_location_id", using: :btree
  add_index "venues", ["token"], name: "index_venues_on_token", unique: true, using: :btree

  create_table "withdraws", force: :cascade do |t|
    t.integer  "user_id",                              null: false
    t.string   "amount",                               null: false
    t.integer  "seller_account_id",                    null: false
    t.string   "status",            default: "Active", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "bookmarks", "gigs"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "buyer_accounts", "users"
  add_foreign_key "charges", "buyer_accounts"
  add_foreign_key "charges", "requests"
  add_foreign_key "charges", "users"
  add_foreign_key "cities_wants", "users"
  add_foreign_key "credits", "users"
  add_foreign_key "devices", "users"
  add_foreign_key "gig_likes", "gigs"
  add_foreign_key "gig_likes", "users"
  add_foreign_key "gig_neighborhood_associations", "gigs"
  add_foreign_key "gig_neighborhood_associations", "neighborhoods"
  add_foreign_key "gigs", "categories"
  add_foreign_key "gigs", "users"
  add_foreign_key "issues", "requests"
  add_foreign_key "issues", "users", column: "sender_id"
  add_foreign_key "locations", "gigs"
  add_foreign_key "messages", "requests"
  add_foreign_key "messages", "users"
  add_foreign_key "my_promo_codes", "promo_codes"
  add_foreign_key "my_promo_codes", "users"
  add_foreign_key "neighborhoods", "cities"
  add_foreign_key "promo_codes", "users"
  add_foreign_key "recent_activities", "users"
  add_foreign_key "referral_codes", "users"
  add_foreign_key "requests", "gigs"
  add_foreign_key "requests", "users", column: "buyer_id"
  add_foreign_key "requests", "users", column: "seller_id"
  add_foreign_key "reviews", "requests"
  add_foreign_key "reviews", "users"
  add_foreign_key "seller_accounts", "users"
  add_foreign_key "used_referral_codes", "referral_codes"
  add_foreign_key "used_referral_codes", "users"
  add_foreign_key "users", "cities"
  add_foreign_key "withdraws", "seller_accounts"
  add_foreign_key "withdraws", "users"
end
