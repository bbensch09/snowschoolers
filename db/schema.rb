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

ActiveRecord::Schema.define(version: 20160706062545) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beta_users", force: true do |t|
    t.string   "email"
    t.string   "user_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lesson_times", force: true do |t|
    t.date   "date"
    t.string "slot"
  end

  create_table "lessons", force: true do |t|
    t.integer  "requester_id"
    t.integer  "instructor_id"
    t.integer  "lesson_time_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "activity"
    t.string   "location"
    t.boolean  "gear"
    t.text     "objectives"
    t.string   "state"
    t.integer  "duration"
    t.string   "start_time"
    t.string   "actual_start_time"
    t.string   "actual_end_time"
    t.float    "actual_duration"
    t.integer  "experience_level"
    t.boolean  "terms_accepted"
  end

  create_table "lessons_previous_experiences", id: false, force: true do |t|
    t.integer "lesson_id",              null: false
    t.integer "previous_experience_id", null: false
  end

  create_table "previous_experiences", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.integer "lesson_id"
    t.string  "name"
    t.string  "age_range"
    t.string  "gender"
    t.string  "relationship_to_requester"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.boolean  "instructor"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
