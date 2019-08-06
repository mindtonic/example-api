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

ActiveRecord::Schema.define(version: 2019_08_06_204123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.string "key"
    t.string "secret"
    t.string "ip_address"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_api_keys_on_active"
    t.index ["key", "secret", "ip_address", "active"], name: "index_api_keys_on_key_and_secret_and_ip_address_and_active"
    t.index ["key"], name: "index_api_keys_on_key"
    t.index ["secret"], name: "index_api_keys_on_secret"
  end

  create_table "boards", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.uuid "public_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["public_token"], name: "index_boards_on_public_token", unique: true
  end

  create_table "saves", force: :cascade do |t|
    t.bigint "board_id"
    t.bigint "saved_board_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id", "saved_board_id"], name: "index_saves_on_board_id_and_saved_board_id", unique: true
    t.index ["board_id"], name: "index_saves_on_board_id"
    t.index ["saved_board_id"], name: "index_saves_on_saved_board_id"
  end

  add_foreign_key "saves", "boards"
  add_foreign_key "saves", "boards", column: "saved_board_id"
end
