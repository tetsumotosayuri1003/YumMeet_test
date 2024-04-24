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

ActiveRecord::Schema[7.1].define(version: 2024_04_23_143808) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "board_tag_maps", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_board_tag_maps_on_board_id"
    t.index ["tag_id"], name: "index_board_tag_maps_on_tag_id"
  end

  create_table "boards", force: :cascade do |t|
    t.text "comment"
    t.bigint "user_id", null: false
    t.bigint "spot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "board_image"
    t.integer "rating_star"
    t.index ["spot_id"], name: "index_boards_on_spot_id"
    t.index ["user_id"], name: "index_boards_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "board_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_comments_on_board_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "board_id", null: false
    t.string "favorite_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_favorites_on_board_id"
    t.index ["user_id", "board_id", "favorite_type"], name: "index_favorites_on_user_id_and_board_id_and_favorite_type", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "spots", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "avatar"
    t.string "username"
    t.string "slug"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "board_tag_maps", "boards"
  add_foreign_key "board_tag_maps", "tags"
  add_foreign_key "boards", "spots"
  add_foreign_key "boards", "users"
  add_foreign_key "comments", "boards"
  add_foreign_key "comments", "users"
  add_foreign_key "favorites", "boards"
  add_foreign_key "favorites", "users"
end
