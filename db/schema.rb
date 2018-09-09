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

ActiveRecord::Schema.define(version: 20180909103457) do

  create_table "comments", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hikes", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.text "equipment"
    t.string "difficulty"
    t.float "distance"
    t.float "avg_time"
    t.text "nature"
    t.float "max_height"
    t.float "min_height"
    t.float "level_difference"
    t.float "rating"
    t.string "type"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "gender"
    t.datetime "birthdate"
    t.string "nickname"
    t.string "email"
    t.text "description"
    t.string "city"
    t.string "encrypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
