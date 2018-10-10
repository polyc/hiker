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

ActiveRecord::Schema.define(version: 20181003132552) do

  create_table "bans", force: :cascade do |t|
    t.integer "condemner_id"
    t.integer "banned_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["banned_id"], name: "index_bans_on_banned_id"
    t.index ["condemner_id", "banned_id"], name: "index_bans_on_condemner_id_and_banned_id", unique: true
    t.index ["condemner_id"], name: "index_bans_on_condemner_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "hike_id"
    t.index ["hike_id"], name: "index_comments_on_hike_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "favoriter_id"
    t.integer "favoritable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["favoritable_id"], name: "index_favorites_on_favoritable_id"
    t.index ["favoriter_id", "favoritable_id"], name: "index_favorites_on_favoriter_id_and_favoritable_id", unique: true
  end

  create_table "hikes", force: :cascade do |t|
    t.string "name"
    t.string "route"
    t.text "equipment"
    t.string "difficulty"
    t.float "distance"
    t.float "avg_time"
    t.text "nature"
    t.float "max_height"
    t.float "min_height"
    t.float "level_difference"
    t.float "rating"
    t.string "tipo"
    t.text "description"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hike_image"
    t.index ["user_id"], name: "index_hikes_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
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
    t.string "provider"
    t.string "uid"
    t.string "image"
    t.string "hike_pref"
    t.integer "private_profile"
  end

end
