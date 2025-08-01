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

ActiveRecord::Schema[8.0].define(version: 2025_07_23_175803) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "memberships", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "user_id", null: false
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_memberships_on_team_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "ranked_lists", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "ranking_method", default: 0
    t.bigint "team_id", null: false
    t.boolean "visible", default: true
    t.integer "items_count", default: 0
    t.integer "votes_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "team_id"], name: "index_ranked_lists_on_name_and_team_id", unique: true
    t.index ["team_id"], name: "index_ranked_lists_on_team_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "visible"
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_teams_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_url"
    t.boolean "visible", default: false
    t.text "who_am_i"
    t.integer "site_role", default: 0
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["visible"], name: "index_users_on_visible"
  end

  add_foreign_key "memberships", "teams"
  add_foreign_key "memberships", "users"
  add_foreign_key "ranked_lists", "teams"
  add_foreign_key "sessions", "users"
  add_foreign_key "teams", "users", column: "owner_id"
end
