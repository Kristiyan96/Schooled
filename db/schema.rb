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

ActiveRecord::Schema.define(version: 2018_05_17_082113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "subject_id"
    t.bigint "school_id"
    t.bigint "school_year_id"
    t.bigint "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_courses_on_group_id"
    t.index ["school_id"], name: "index_courses_on_school_id"
    t.index ["school_year_id"], name: "index_courses_on_school_year_id"
    t.index ["subject_id"], name: "index_courses_on_subject_id"
    t.index ["teacher_id"], name: "index_courses_on_teacher_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.bigint "school_id"
    t.bigint "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_groups_on_school_id"
    t.index ["teacher_id"], name: "index_groups_on_teacher_id"
  end

  create_table "guardianships", force: :cascade do |t|
    t.bigint "parent_id"
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_guardianships_on_parent_id"
    t.index ["student_id"], name: "index_guardianships_on_student_id"
  end

  create_table "headmasters", force: :cascade do |t|
    t.bigint "school_id", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_headmasters_on_school_id"
  end

  create_table "marks", force: :cascade do |t|
    t.decimal "grade"
    t.bigint "course_id"
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_marks_on_course_id"
    t.index ["student_id"], name: "index_marks_on_student_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "text", null: false
    t.string "recepient_type"
    t.bigint "recepient_id"
    t.string "sender_type"
    t.bigint "sender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recepient_type", "recepient_id"], name: "index_messages_on_recepient_type_and_recepient_id"
    t.index ["sender_type", "sender_id"], name: "index_messages_on_sender_type_and_sender_id"
  end

  create_table "parents", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "remarks", force: :cascade do |t|
    t.text "message"
    t.bigint "course_id"
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_remarks_on_course_id"
    t.index ["student_id"], name: "index_remarks_on_student_id"
  end

  create_table "school_years", force: :cascade do |t|
    t.bigint "school_id"
    t.string "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_school_years_on_school_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "contact_number"
    t.string "email"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.bigint "school_id", null: false
    t.bigint "group_id"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "first_name", null: false
    t.string "middle_name"
    t.string "last_name", null: false
    t.date "birthday", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_students_on_group_id"
    t.index ["school_id"], name: "index_students_on_school_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.bigint "school_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_subjects_on_school_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.bigint "school_id"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_teachers_on_school_id"
  end

  add_foreign_key "courses", "groups"
  add_foreign_key "courses", "school_years"
  add_foreign_key "courses", "schools"
  add_foreign_key "courses", "subjects"
  add_foreign_key "courses", "teachers"
  add_foreign_key "groups", "schools"
  add_foreign_key "groups", "teachers"
  add_foreign_key "marks", "courses"
  add_foreign_key "marks", "students"
  add_foreign_key "remarks", "courses"
  add_foreign_key "remarks", "students"
end
