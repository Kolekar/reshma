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

ActiveRecord::Schema.define(version: 20190104152528) do

  create_table "collections", force: :cascade do |t|
    t.float "rate", null: false
    t.float "snf"
    t.float "fat", null: false
    t.float "degree"
    t.boolean "animal_type", null: false
    t.boolean "time", null: false
    t.float "litre", null: false
    t.integer "user_id", null: false
    t.date "collection_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dairy_id"
    t.index ["dairy_id"], name: "index_collections_on_dairy_id"
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "dairies", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "mobile", default: "", null: false
    t.string "name", default: "", null: false
    t.text "address", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_dairies_on_email", unique: true
    t.index ["reset_password_token"], name: "index_dairies_on_reset_password_token", unique: true
  end

  create_table "rates", force: :cascade do |t|
    t.float "snf"
    t.float "fat", null: false
    t.float "degree"
    t.float "rate", null: false
    t.boolean "animal_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dairy_id"
    t.index ["dairy_id"], name: "index_rates_on_dairy_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "mobile", null: false
    t.string "name", null: false
    t.text "address", null: false
    t.boolean "animal_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dairy_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["dairy_id"], name: "index_users_on_dairy_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
