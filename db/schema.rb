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

ActiveRecord::Schema.define(version: 20170722112315) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_group_teachers", force: :cascade do |t|
    t.bigint "course_group_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_group_id"], name: "index_course_group_teachers_on_course_group_id"
    t.index ["user_id"], name: "index_course_group_teachers_on_user_id"
  end

  create_table "course_groups", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_groups_on_course_id"
    t.index ["group_id"], name: "index_course_groups_on_group_id"
  end

  create_table "course_students", id: false, force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "user_id"
    t.float "first_term_mark"
    t.float "second_term_mark"
    t.float "final_mark"
    t.index ["course_id"], name: "index_course_students_on_course_id"
    t.index ["user_id"], name: "index_course_students_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "subject_id"
    t.bigint "school_id"
    t.integer "year"
    t.index ["school_id"], name: "index_courses_on_school_id"
    t.index ["subject_id"], name: "index_courses_on_subject_id"
  end

  create_table "groups", force: :cascade do |t|
    t.integer "grade"
    t.string "name"
    t.bigint "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_groups_on_school_id"
  end

  create_table "marks", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "user_id"
    t.integer "mark"
    t.boolean "approved"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_marks_on_course_id"
    t.index ["user_id"], name: "index_marks_on_user_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.integer "grade"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "school_id"
    t.bigint "group_id"
    t.integer "role", default: 0
    t.boolean "admin", default: false
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accepted", default: false
    t.index ["group_id"], name: "index_users_on_group_id"
    t.index ["school_id"], name: "index_users_on_school_id"
  end

  add_foreign_key "course_groups", "courses"
  add_foreign_key "course_groups", "groups"
  add_foreign_key "groups", "schools"
end
