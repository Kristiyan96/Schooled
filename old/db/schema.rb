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

ActiveRecord::Schema.define(version: 20170827183042) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "absences", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.decimal "excused", default: "0.0", null: false
    t.decimal "permanent", default: "0.0", null: false
    t.integer "purpose", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_absences_on_course_id"
    t.index ["user_id"], name: "index_absences_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "subject_id"
    t.bigint "school_id"
    t.bigint "group_id"
    t.bigint "user_id"
    t.integer "year", null: false
    t.integer "grade", null: false
    t.integer "study_hours", null: false
    t.string "room"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_courses_on_group_id"
    t.index ["school_id"], name: "index_courses_on_school_id"
    t.index ["subject_id"], name: "index_courses_on_subject_id"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "school_id"
    t.bigint "user_id"
    t.integer "grade", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_groups_on_school_id"
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.string "identification"
    t.string "address"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_invitations_on_group_id"
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "group_id"
    t.bigint "slot_id"
    t.integer "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_lessons_on_course_id"
    t.index ["group_id"], name: "index_lessons_on_group_id"
    t.index ["slot_id"], name: "index_lessons_on_slot_id"
  end

  create_table "marks", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "user_id"
    t.integer "mark", null: false
    t.integer "purpose", default: 0
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_marks_on_course_id"
    t.index ["user_id"], name: "index_marks_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "title", limit: 255
    t.string "text"
    t.string "entity_type"
    t.integer "entity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parentships", force: :cascade do |t|
    t.integer "parent_id"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.string "phone_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slots", force: :cascade do |t|
    t.bigint "school_id"
    t.integer "start_time"
    t.integer "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_slots_on_school_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", null: false
    t.string "abbreviation", null: false
    t.integer "grade", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.bigint "school_id"
    t.bigint "group_id"
    t.integer "role", default: 0
    t.integer "number"
    t.boolean "admin", default: false
    t.boolean "accepted", default: false
    t.string "name"
    t.string "email", null: false
    t.string "address"
    t.string "password_digest"
    t.string "identification"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_users_on_group_id"
    t.index ["school_id"], name: "index_users_on_school_id"
  end

  add_foreign_key "groups", "schools"
  add_foreign_key "groups", "users"
  add_foreign_key "lessons", "courses"
  add_foreign_key "lessons", "groups"
  add_foreign_key "lessons", "slots"
  add_foreign_key "slots", "schools"
end
