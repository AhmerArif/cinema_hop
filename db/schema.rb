# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131022141322) do

  create_table "cinemas", force: true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cinemas", ["city_id"], name: "index_cinemas_on_city_id", using: :btree
  add_index "cinemas", ["name"], name: "index_cinemas_on_name", unique: true, using: :btree

  create_table "cities", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["slug"], name: "index_cities_on_slug", unique: true, using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "movies", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "imdb_link"
    t.string   "rotten_tomatoes_link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movies", ["slug"], name: "index_movies_on_slug", using: :btree

  create_table "showtimes", force: true do |t|
    t.integer  "movie_id"
    t.integer  "cinema_id"
    t.datetime "showing_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "showtimes", ["cinema_id"], name: "index_showtimes_on_cinema_id", using: :btree
  add_index "showtimes", ["movie_id"], name: "index_showtimes_on_movie_id", using: :btree

end
