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

ActiveRecord::Schema[7.0].define(version: 2023_05_29_144824) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
  end

  create_table "comments", force: :cascade do |t|
    t.string "author"
    t.text "body"
    t.bigint "article_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["article_id"], name: "index_comments_on_article_id"
  end

  create_table "match_series", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "match_series_participations", force: :cascade do |t|
    t.bigint "match_series_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_series_id"], name: "index_match_series_participations_on_match_series_id"
    t.index ["user_id"], name: "index_match_series_participations_on_user_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "match_series_id"
    t.integer "score_a"
    t.integer "score_b"
    t.integer "score_tiebreak_a"
    t.integer "score_tiebreak_b"
    t.datetime "played_at", null: false
    t.bigint "player_a_1_id"
    t.bigint "player_a_2_id"
    t.bigint "player_b_1_id"
    t.bigint "player_b_2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_series_id"], name: "index_matches_on_match_series_id"
    t.index ["player_a_1_id"], name: "index_matches_on_player_a_1_id"
    t.index ["player_a_2_id"], name: "index_matches_on_player_a_2_id"
    t.index ["player_b_1_id"], name: "index_matches_on_player_b_1_id"
    t.index ["player_b_2_id"], name: "index_matches_on_player_b_2_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "articles"
  add_foreign_key "match_series_participations", "match_series"
  add_foreign_key "match_series_participations", "users"
  add_foreign_key "matches", "match_series"
  add_foreign_key "matches", "users", column: "player_a_1_id"
  add_foreign_key "matches", "users", column: "player_a_2_id"
  add_foreign_key "matches", "users", column: "player_b_1_id"
  add_foreign_key "matches", "users", column: "player_b_2_id"
end
