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

ActiveRecord::Schema.define(version: 20160726170452) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.integer  "grove_id"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image"
  end

  add_index "activities", ["grove_id"], name: "index_activities_on_grove_id", using: :btree
  add_index "activities", ["location_id"], name: "index_activities_on_location_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "user_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "events", ["location_id"], name: "index_events_on_location_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "focus_areas", force: :cascade do |t|
    t.string   "name"
    t.integer  "grove_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "focus_areas", ["grove_id"], name: "index_focus_areas_on_grove_id", using: :btree

  create_table "groves", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image"
  end

  add_index "groves", ["school_id"], name: "index_groves_on_school_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.integer  "grove_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image"
  end

  add_index "locations", ["grove_id"], name: "index_locations_on_grove_id", using: :btree

  create_table "playlist_activities", force: :cascade do |t|
    t.integer  "activity_id"
    t.integer  "focus_area_id"
    t.integer  "position"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
  end

  add_index "playlist_activities", ["activity_id"], name: "index_playlist_activities_on_activity_id", using: :btree
  add_index "playlist_activities", ["focus_area_id"], name: "index_playlist_activities_on_focus_area_id", using: :btree
  add_index "playlist_activities", ["user_id"], name: "index_playlist_activities_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scans", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "location_id"
    t.boolean  "correct"
    t.datetime "timestamp"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "scans", ["event_id"], name: "index_scans_on_event_id", using: :btree
  add_index "scans", ["location_id"], name: "index_scans_on_location_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image"
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.integer  "school_id"
    t.integer  "grove_id"
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "type"
    t.string   "token"
    t.string   "refresh_token"
    t.integer  "expires_at"
    t.boolean  "at_school"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["grove_id"], name: "index_users_on_grove_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["school_id"], name: "index_users_on_school_id", using: :btree

  add_foreign_key "activities", "groves"
  add_foreign_key "activities", "locations"
  add_foreign_key "events", "locations"
  add_foreign_key "events", "users"
  add_foreign_key "focus_areas", "groves"
  add_foreign_key "groves", "schools"
  add_foreign_key "locations", "groves"
  add_foreign_key "playlist_activities", "activities"
  add_foreign_key "playlist_activities", "focus_areas"
  add_foreign_key "playlist_activities", "users"
  add_foreign_key "scans", "events"
  add_foreign_key "scans", "locations"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
  add_foreign_key "users", "groves"
  add_foreign_key "users", "schools"
end
