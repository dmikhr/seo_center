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

ActiveRecord::Schema.define(version: 2019_10_30_083215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "websites", force: :cascade do |t|
    t.string "url"
    t.boolean "www"
    t.boolean "https"
    t.datetime "scanned_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "robots_txt"
  end

  add_foreign_key "links", "pages"
  add_foreign_key "metas", "pages"
  add_foreign_key "pages", "websites"
end
