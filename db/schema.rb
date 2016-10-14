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

ActiveRecord::Schema.define(version: 20161014094914) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actor_images", force: true do |t|
    t.string  "url"
    t.integer "actor_id"
  end

  add_index "actor_images", ["actor_id"], name: "index_actor_images_on_actor_id", using: :btree

  create_table "actors", force: true do |t|
    t.text "name"
  end

  create_table "actors_movies", id: false, force: true do |t|
    t.integer "movie_id"
    t.integer "actor_id"
  end

  add_index "actors_movies", ["actor_id"], name: "index_actors_movies_on_actor_id", using: :btree
  add_index "actors_movies", ["movie_id"], name: "index_actors_movies_on_movie_id", using: :btree

  create_table "comments", force: true do |t|
    t.text     "comment"
    t.integer  "customer_id"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["customer_id"], name: "index_comments_on_customer_id", using: :btree
  add_index "comments", ["movie_id"], name: "index_comments_on_movie_id", using: :btree

  create_table "countries", force: true do |t|
    t.string "name"
  end

  create_table "countries_movies", id: false, force: true do |t|
    t.integer "movie_id"
    t.integer "country_id"
  end

  add_index "countries_movies", ["country_id"], name: "index_countries_movies_on_country_id", using: :btree
  add_index "countries_movies", ["movie_id"], name: "index_countries_movies_on_movie_id", using: :btree

  create_table "customers", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "stripe_id"
    t.string   "country"
    t.string   "city"
    t.string   "street_address"
    t.string   "zip_code"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true, using: :btree
  add_index "customers", ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true, using: :btree

  create_table "genres", force: true do |t|
    t.text "genre"
  end

  create_table "genres_movies", id: false, force: true do |t|
    t.integer "movie_id"
    t.integer "genre_id"
  end

  add_index "genres_movies", ["genre_id"], name: "index_genres_movies_on_genre_id", using: :btree
  add_index "genres_movies", ["movie_id"], name: "index_genres_movies_on_movie_id", using: :btree

  create_table "movies", force: true do |t|
    t.text     "imdb_id"
    t.text     "title"
    t.text     "year"
    t.text     "runtime"
    t.date     "released"
    t.text     "director",            default: [], array: true
    t.text     "writer",              default: [], array: true
    t.float    "imdb_rating"
    t.float    "imdb_votes"
    t.text     "short_plot"
    t.text     "full_plot"
    t.text     "language"
    t.text     "country"
    t.text     "awards"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price"
    t.string   "poster_file_name"
    t.string   "poster_content_type"
    t.integer  "poster_file_size"
    t.datetime "poster_updated_at"
  end

  create_table "rentals", force: true do |t|
    t.integer  "customer_id"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rentals", ["customer_id"], name: "index_rentals_on_customer_id", using: :btree
  add_index "rentals", ["movie_id"], name: "index_rentals_on_movie_id", using: :btree

end
