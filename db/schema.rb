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

ActiveRecord::Schema.define(version: 2019_09_05_103933) do

  create_table "categories", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "shop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dizzies", force: :cascade do |t|
    t.integer "menu_item_id", null: false
    t.integer "shop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grins", force: :cascade do |t|
    t.integer "menu_item_id", null: false
    t.integer "shop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "happies", force: :cascade do |t|
    t.integer "menu_item_id", null: false
    t.integer "shop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_groups", force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "menu_id", null: false
    t.string "group_image_id"
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menu_items", force: :cascade do |t|
    t.integer "item_group_id", null: false
    t.string "item_image_id"
    t.string "item_name", default: "", null: false
    t.text "item_text"
    t.integer "price", null: false
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menus", force: :cascade do |t|
    t.string "menu_name", default: "", null: false
    t.string "menu_color", default: "#fff"
    t.integer "shop_id", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "shop_id", null: false
    t.string "email", default: "", null: false
    t.text "message", default: "", null: false
    t.string "title", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "shop_name", default: "", null: false
    t.integer "postal_code", null: false
    t.integer "state", null: false
    t.string "city", default: "", null: false
    t.string "street", default: "", null: false
    t.integer "phone_number", null: false
    t.string "shop_color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_shops_on_email", unique: true
    t.index ["reset_password_token"], name: "index_shops_on_reset_password_token", unique: true
  end

  create_table "special_features", force: :cascade do |t|
    t.integer "menu_id", default: 0, null: false
    t.string "feature_image_id", default: "", null: false
    t.string "title", default: "", null: false
    t.text "body", default: "", null: false
    t.string "column_color", default: "#ffffff", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
