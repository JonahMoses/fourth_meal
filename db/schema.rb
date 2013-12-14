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

ActiveRecord::Schema.define(version: 20131214213555) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_categories", force: true do |t|
    t.integer "item_id"
    t.integer "category_id"
  end

  create_table "items", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "price",              precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                                     default: true
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "restaurant_id"
  end

  add_index "items", ["active"], name: "index_items_on_active"

  create_table "order_items", force: true do |t|
    t.integer  "item_id"
    t.integer  "order_id"
    t.integer  "quantity",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "restaurant_id"
  end

  add_index "orders", ["status"], name: "index_orders_on_status"

  create_table "regions", force: true do |t|
    t.string "name"
  end

  create_table "restaurants", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",      default: "pending"
    t.string   "slug"
    t.integer  "region_id"
  end

  add_index "restaurants", ["region_id"], name: "index_restaurants_on_region_id"
  add_index "restaurants", ["status"], name: "index_restaurants_on_status"

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "full_name"
    t.string   "display_name"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "guest"
    t.boolean  "admin",                         default: false
    t.string   "credit_card_number", limit: 16
    t.integer  "billing_address"
    t.integer  "shipping_address"
    t.string   "billing_street"
    t.string   "shipping_street"
    t.string   "billing_apt"
    t.string   "shipping_apt"
    t.string   "billing_city"
    t.string   "shipping_city"
    t.string   "billing_state"
    t.string   "shipping_state"
    t.string   "billing_zip_code",   limit: 5
    t.string   "shipping_zip_code",  limit: 5
  end

end
