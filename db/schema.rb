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

  create_table "courses", force: :cascade do |t|
    t.bigint "school_id", null: false
    t.date "year", null: false
    t.index ["school_id"], name: "index_courses_on_school_id"
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "school_id", null: false
    t.integer "grade", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_groups_on_school_id"
  end

  create_table "marks", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "user_id", null: false
    t.float "mark", null: false
    t.integer "purpose", default: 0, null: false
    t.boolean "approved", default: false, null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_marks_on_course_id"
    t.index ["user_id"], name: "index_marks_on_user_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.string "phone_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_classes", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_student_classes_on_course_id"
    t.index ["group_id"], name: "index_student_classes_on_group_id"
    t.index ["user_id"], name: "index_student_classes_on_user_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.string "name", null: false
    t.integer "grade", null: false
    t.index ["course_id"], name: "index_subjects_on_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "school_id"
    t.bigint "group_id"
    t.bigint "parent_id"
    t.integer "role", default: 0, null: false
    t.boolean "admin", default: false, null: false
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "address"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accepted", default: false
    t.index ["group_id"], name: "index_users_on_group_id"
    t.index ["parent_id"], name: "index_users_on_parent_id"
    t.index ["school_id"], name: "index_users_on_school_id"
  end

  add_foreign_key "courses", "schools"
  add_foreign_key "groups", "schools"
  add_foreign_key "marks", "courses"
  add_foreign_key "marks", "users"
  add_foreign_key "student_classes", "courses"
  add_foreign_key "student_classes", "groups"
  add_foreign_key "student_classes", "users"
  add_foreign_key "subjects", "courses"
  add_foreign_key "users", "groups"
  add_foreign_key "users", "schools"
end
