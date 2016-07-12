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

ActiveRecord::Schema.define(version: 20160712174710) do

  create_table "districts", force: :cascade do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string   "subject"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "politician_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "politicians", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "party"
    t.string   "religion"
    t.string   "prior_experience"
    t.string   "education"
    t.integer  "birth_year"
    t.string   "email"
    t.integer  "state_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "in_office?",       default: false
  end

  create_table "representatives", force: :cascade do |t|
    t.integer  "politician_id"
    t.integer  "district_id"
    t.integer  "in_office_since"
    t.integer  "term_ends"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.string   "abbreviation", limit: 2
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "street_address"
    t.string   "city"
    t.string   "email"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "zipcode"
    t.integer  "state_id"
  end

end
