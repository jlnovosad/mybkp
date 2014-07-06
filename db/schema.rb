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

ActiveRecord::Schema.define(version: 20140706144638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "popular"
  end

  add_index "categories", ["created_at"], name: "index_categories_on_created_at", using: :btree

  create_table "drink_categories", force: true do |t|
    t.integer  "drink_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "drink_categories", ["drink_id", "category_id"], name: "index_drink_categories_on_drink_id_and_category_id", using: :btree

  create_table "drinks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "popular"
    t.integer  "user_id"
  end

  add_index "drinks", ["created_at"], name: "index_drinks_on_created_at", using: :btree
  add_index "drinks", ["user_id"], name: "index_drinks_on_user_id", using: :btree

  create_table "favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["user_id", "venue_id"], name: "index_favorites_on_user_id_and_venue_id", using: :btree

  create_table "locations", force: true do |t|
    t.text     "city"
    t.text     "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["created_at"], name: "index_locations_on_created_at", using: :btree

  create_table "micropost_users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "micropost_id"
    t.integer  "user_id"
  end

  add_index "micropost_users", ["micropost_id"], name: "index_micropost_users_on_micropost_id", using: :btree
  add_index "micropost_users", ["user_id"], name: "index_micropost_users_on_user_id", using: :btree

  create_table "microposts", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "venue_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "working"
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at", using: :btree

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "user_drinks", force: true do |t|
    t.integer  "user_id"
    t.integer  "drink_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_drinks", ["user_id", "drink_id"], name: "index_user_drinks_on_user_id_and_drink_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                             default: "",   null: false
    t.string   "name",                              default: "",   null: false
    t.string   "tender",                            default: "NO", null: false
    t.string   "encrypted_password",                default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "invitation_token",       limit: 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "notify"
    t.string   "privateprofile",                    default: "NO"
    t.string   "venueprofile"
    t.integer  "location_id"
    t.string   "featured"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "venues", force: true do |t|
    t.string   "fs_venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "venues", ["fs_venue_id", "created_at"], name: "index_venues_on_fs_venue_id_and_created_at", using: :btree

  create_table "workfavorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workfavorites", ["user_id", "venue_id"], name: "index_workfavorites_on_user_id_and_venue_id", using: :btree

end
