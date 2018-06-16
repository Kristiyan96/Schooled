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

ActiveRecord::Schema.define(version: 2018_06_05_120209) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "absences", force: :cascade do |t|
    t.string "value", default: "0/1", null: false
    t.integer "kind", default: 0, null: false
    t.integer "category", default: 0, null: false
    t.integer "student_id"
    t.bigint "schedule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_absences_on_schedule_id"
    t.index ["student_id"], name: "index_absences_on_student_id"
  end

  create_table "assignments", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "user_id"
    t.bigint "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_assignments_on_role_id"
    t.index ["school_id"], name: "index_assignments_on_school_id"
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "subject_id"
    t.bigint "school_id"
    t.bigint "school_year_id"
    t.integer "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_courses_on_group_id"
    t.index ["school_id"], name: "index_courses_on_school_id"
    t.index ["school_year_id"], name: "index_courses_on_school_year_id"
    t.index ["subject_id"], name: "index_courses_on_subject_id"
  end

  create_table "groups", force: :cascade do |t|
    t.integer "grade"
    t.string "name"
    t.integer "teacher_id"
    t.bigint "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_groups_on_school_id"
  end

  create_table "homeworks", force: :cascade do |t|
    t.string "title"
    t.date "deadline"
    t.text "description"
    t.integer "teacher_id"
    t.bigint "group_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_homeworks_on_course_id"
    t.index ["group_id"], name: "index_homeworks_on_group_id"
  end

  create_table "marks", force: :cascade do |t|
    t.decimal "grade", null: false
    t.text "note"
    t.integer "kind", default: 0, null: false
    t.integer "student_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_marks_on_course_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "text", null: false
    t.boolean "read", default: false, null: false
    t.string "sender_type"
    t.bigint "sender_id"
    t.string "recepient_type"
    t.bigint "recepient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recepient_type", "recepient_id"], name: "index_messages_on_recepient_type_and_recepient_id"
    t.index ["sender_type", "sender_id"], name: "index_messages_on_sender_type_and_sender_id"
  end

  create_table "parentships", force: :cascade do |t|
    t.integer "parent_id"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id", "student_id"], name: "index_parentships_on_parent_id_and_student_id", unique: true
  end

  create_table "remarks", force: :cascade do |t|
    t.text "message"
    t.bigint "course_id"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_remarks_on_course_id"
    t.index ["student_id"], name: "index_remarks_on_student_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "time_slot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_schedules_on_course_id"
    t.index ["time_slot_id"], name: "index_schedules_on_time_slot_id"
  end

  create_table "school_years", force: :cascade do |t|
    t.bigint "school_id"
    t.string "year"
    t.boolean "active", default: false, null: false
    t.datetime "start"
    t.datetime "end"
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

  create_table "subjects", force: :cascade do |t|
    t.bigint "school_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_subjects_on_school_id"
  end

  create_table "time_slots", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.string "title"
    t.bigint "school_year_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_year_id"], name: "index_time_slots_on_school_year_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "middle_name"
    t.string "last_name", null: false
    t.string "address"
    t.string "phone_number"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.date "birthday"
    t.string "UCN"
    t.integer "number_in_class"
    t.bigint "group_id"
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["group_id"], name: "index_users_on_group_id"
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "absences", "schedules"
  add_foreign_key "assignments", "roles"
  add_foreign_key "assignments", "schools"
  add_foreign_key "assignments", "users"
  add_foreign_key "courses", "groups"
  add_foreign_key "courses", "school_years"
  add_foreign_key "courses", "schools"
  add_foreign_key "courses", "subjects"
  add_foreign_key "groups", "schools"
  add_foreign_key "homeworks", "courses"
  add_foreign_key "homeworks", "groups"
  add_foreign_key "marks", "courses"
  add_foreign_key "remarks", "courses"
  add_foreign_key "schedules", "courses"
  add_foreign_key "schedules", "time_slots"
  add_foreign_key "subjects", "schools"
  add_foreign_key "time_slots", "school_years"
  add_foreign_key "users", "groups"
end
