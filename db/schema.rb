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

ActiveRecord::Schema.define(version: 20130112071835) do

  create_table "articles", force: true do |t|
    t.integer  "user_id"
    t.integer  "hub_id"
    t.string   "author"
    t.string   "keywords"
    t.string   "description"
    t.string   "copyright"
    t.string   "title"
    t.text     "raw_intro"
    t.text     "raw_content"
    t.text     "intro"
    t.text     "content"
    t.string   "main_image_url"
    t.integer  "show_count",         default: 0
    t.string   "state",              default: "draft"
    t.datetime "first_published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth",              default: 0
    t.integer  "files_count",        default: 0
    t.integer  "files_size",         default: 0
    t.string   "short_id"
    t.string   "slug_id"
    t.string   "friendly_id"
  end

  create_table "blogs", force: true do |t|
    t.integer  "user_id"
    t.integer  "hub_id"
    t.string   "author"
    t.string   "keywords"
    t.string   "description"
    t.string   "copyright"
    t.string   "title"
    t.text     "raw_intro"
    t.text     "raw_content"
    t.text     "intro"
    t.text     "content"
    t.string   "main_image_url"
    t.integer  "show_count",         default: 0
    t.string   "state",              default: "draft"
    t.datetime "first_published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth",              default: 0
    t.integer  "files_count",        default: 0
    t.integer  "files_size",         default: 0
    t.string   "short_id"
    t.string   "slug_id"
    t.string   "friendly_id"
  end

  create_table "hubs", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "hub_type",    default: "pages"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth",       default: 0
    t.string   "short_id"
    t.string   "slug_id"
    t.string   "friendly_id"
  end

  create_table "pages", force: true do |t|
    t.integer  "user_id"
    t.integer  "hub_id"
    t.string   "author"
    t.string   "keywords"
    t.string   "description"
    t.string   "copyright"
    t.string   "title"
    t.text     "raw_intro"
    t.text     "raw_content"
    t.text     "intro"
    t.text     "content"
    t.string   "main_image_url"
    t.integer  "show_count",         default: 0
    t.string   "state",              default: "draft"
    t.datetime "first_published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth",              default: 0
    t.integer  "files_count",        default: 0
    t.integer  "files_size",         default: 0
    t.string   "short_id"
    t.string   "slug_id"
    t.string   "friendly_id"
  end

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.integer  "hub_id"
    t.string   "author"
    t.string   "keywords"
    t.string   "description"
    t.string   "copyright"
    t.string   "title"
    t.text     "raw_intro"
    t.text     "raw_content"
    t.text     "intro"
    t.text     "content"
    t.string   "main_image_url"
    t.integer  "show_count",         default: 0
    t.string   "state",              default: "draft"
    t.datetime "first_published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth",              default: 0
    t.integer  "files_count",        default: 0
    t.integer  "files_size",         default: 0
    t.string   "short_id"
    t.string   "slug_id"
    t.string   "friendly_id"
  end

  create_table "recipes", force: true do |t|
    t.integer  "user_id"
    t.integer  "hub_id"
    t.string   "author"
    t.string   "keywords"
    t.string   "description"
    t.string   "copyright"
    t.string   "title"
    t.text     "raw_intro"
    t.text     "raw_content"
    t.text     "intro"
    t.text     "content"
    t.string   "main_image_url"
    t.integer  "show_count",         default: 0
    t.string   "state",              default: "draft"
    t.datetime "first_published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth",              default: 0
    t.integer  "files_count",        default: 0
    t.integer  "files_size",         default: 0
    t.string   "short_id"
    t.string   "slug_id"
    t.string   "friendly_id"
  end

  create_table "users", force: true do |t|
    t.string   "login",                                       null: false
    t.string   "username",                                    null: false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer  "files_count",                     default: 0
    t.integer  "files_size",                      default: 0
  end

  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token"

end