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

ActiveRecord::Schema.define(version: 2019_11_07_114011) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "htags", force: :cascade do |t|
    t.bigint "page_id"
    t.integer "level"
    t.string "contents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_htags_on_page_id"
  end

  create_table "images", force: :cascade do |t|
    t.bigint "page_id"
    t.string "src"
    t.string "alt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_images_on_page_id"
  end

  create_table "links", force: :cascade do |t|
    t.bigint "page_id"
    t.string "anchor"
    t.string "url"
    t.boolean "internal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_links_on_page_id"
  end

  create_table "metas", force: :cascade do |t|
    t.bigint "page_id"
    t.string "description"
    t.string "author"
    t.string "encoding"
    t.string "keywords"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_metas_on_page_id"
  end

  create_table "pages", force: :cascade do |t|
    t.bigint "website_id"
    t.string "path"
    t.string "contents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "favicon_path"
    t.index ["website_id"], name: "index_pages_on_website_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "websites", force: :cascade do |t|
    t.string "url"
    t.boolean "www"
    t.boolean "https"
    t.datetime "scanned_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "robots_txt"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_websites_on_user_id"
  end

  add_foreign_key "htags", "pages"
  add_foreign_key "images", "pages"
  add_foreign_key "links", "pages"
  add_foreign_key "metas", "pages"
  add_foreign_key "pages", "websites"
  add_foreign_key "websites", "users"
end
