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

ActiveRecord::Schema.define(version: 2019_02_10_151518) do

  create_table "articles", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "track_id"
    t.index ["track_id"], name: "index_articles_on_track_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres_tracks", id: false, force: :cascade do |t|
    t.integer "track_id"
    t.integer "genre_id"
    t.index ["genre_id"], name: "index_genres_tracks_on_genre_id"
    t.index ["track_id"], name: "index_genres_tracks_on_track_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags_tracks", id: false, force: :cascade do |t|
    t.integer "track_id"
    t.integer "tag_id"
    t.index ["tag_id"], name: "index_tags_tracks_on_tag_id"
    t.index ["track_id"], name: "index_tags_tracks_on_track_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "sc_id"
    t.string "url"
    t.string "artist"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.text "comment"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
