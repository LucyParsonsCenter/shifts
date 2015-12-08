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

ActiveRecord::Schema.define(version: 20151208014431) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collective_members", force: :cascade do |t|
    t.text     "first_name",    null: false
    t.text     "last_name"
    t.text     "email_address"
    t.text     "phone_number"
    t.boolean  "trainer"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "collective_members_events", id: false, force: :cascade do |t|
    t.integer "event_id",             null: false
    t.integer "collective_member_id", null: false
  end

  add_index "collective_members_events", ["collective_member_id", "event_id"], name: "why", using: :btree
  add_index "collective_members_events", ["event_id", "collective_member_id"], name: "fooop", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "trainee_id"
    t.boolean  "meeting",    default: false
    t.text     "notes"
    t.datetime "start_time",                 null: false
    t.datetime "end_time",                   null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "events_trainees", id: false, force: :cascade do |t|
    t.integer "event_id",   null: false
    t.integer "trainee_id", null: false
  end

  add_index "events_trainees", ["event_id", "trainee_id"], name: "flasdf", using: :btree
  add_index "events_trainees", ["trainee_id", "event_id"], name: "foobar", using: :btree

  create_table "trainees", force: :cascade do |t|
    t.text     "first_name"
    t.text     "email_address"
    t.text     "phone_number"
    t.text     "notes"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "last_name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
