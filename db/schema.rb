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

ActiveRecord::Schema.define(version: 20140124192421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "access_token"
    t.string   "access_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
  end

  create_table "campaigns", force: true do |t|
    t.string   "title"
    t.string   "type"
    t.string   "search_string"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "is_active",            default: false
    t.integer  "spams_per_day",        default: 0
    t.boolean  "should_auto_activate", default: false
    t.integer  "tweets_sent_count",    default: 0
    t.integer  "authentication_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "communications", force: true do |t|
    t.string   "search_string"
    t.string   "text_found"
    t.string   "text_sent"
    t.string   "username"
    t.integer  "authentication_id"
    t.integer  "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversation_starters", force: true do |t|
    t.integer  "campaign_id"
    t.string   "text"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
