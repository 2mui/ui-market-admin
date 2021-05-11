# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_11_030219) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "auth_providers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_auth_providers_on_user_id"
  end

  create_table "banners", force: :cascade do |t|
    t.string "image"
    t.string "alt"
    t.integer "position"
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discarded_at"], name: "index_banners_on_discarded_at"
  end

  create_table "browse_histories", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id", "user_id"], name: "browse_histories_item_id_user_id_key", unique: true
    t.index ["item_id"], name: "index_browse_histories_on_item_id"
    t.index ["user_id"], name: "index_browse_histories_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "download_histories", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id", "user_id"], name: "download_histories_item_id_user_id_key", unique: true
    t.index ["item_id"], name: "index_download_histories_on_item_id"
    t.index ["user_id"], name: "index_download_histories_on_user_id"
  end

  create_table "filetypes", force: :cascade do |t|
    t.string "ext"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "folders", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "user_id"], name: "folders_name_user_id_key", unique: true
    t.index ["user_id"], name: "index_folders_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "cover"
    t.string "detail"
    t.string "url"
    t.string "author", default: "二木设计"
    t.bigint "category_id", null: false
    t.bigint "industry_id", null: false
    t.integer "likes_count", default: 0
    t.integer "downloads_count", default: 0
    t.integer "browses_count", default: 0
    t.string "filesize", default: "0"
    t.boolean "featured", default: false
    t.boolean "draft", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "filetype"
    t.bigint "upload_by"
    t.datetime "discarded_at"
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["discarded_at"], name: "index_items_on_discarded_at"
    t.index ["industry_id"], name: "index_items_on_industry_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "user_id", null: false
    t.bigint "folder_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["folder_id"], name: "index_likes_on_folder_id"
    t.index ["item_id", "user_id"], name: "likes_item_id_user_id_key", unique: true
    t.index ["item_id"], name: "index_likes_on_item_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "partners", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "image"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "resource_categories", force: :cascade do |t|
    t.string "category_name"
    t.string "link_to_extract"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "resource_details", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "cover"
    t.string "detail"
    t.string "url"
    t.integer "category_id"
    t.integer "industry_id"
    t.integer "upload_by"
    t.boolean "featured", default: false
    t.boolean "draft", default: true
    t.boolean "processed", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "filetypes"
    t.string "request_id"
    t.string "original_url"
  end

  create_table "resource_items", force: :cascade do |t|
    t.string "title"
    t.string "link"
    t.boolean "scraped"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "request_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "login"
    t.string "qq"
    t.string "mobile_phone"
    t.string "nickname"
    t.string "gender"
    t.string "avatar"
    t.string "occupation"
    t.string "city"
    t.string "cid"
    t.string "name"
    t.datetime "last_login_at"
    t.string "last_login_location"
    t.string "role", default: "user"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "auth_providers", "users"
  add_foreign_key "browse_histories", "items"
  add_foreign_key "browse_histories", "users"
  add_foreign_key "download_histories", "items"
  add_foreign_key "download_histories", "users"
  add_foreign_key "folders", "users"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "industries"
  add_foreign_key "likes", "folders"
  add_foreign_key "likes", "items"
  add_foreign_key "likes", "users"
end
