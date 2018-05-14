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

ActiveRecord::Schema.define(version: 2018_05_14_131141) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "classrooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guardianships", force: :cascade do |t|
    t.bigint "parents_id"
    t.bigint "students_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parents_id"], name: "index_guardianships_on_parents_id"
    t.index ["students_id"], name: "index_guardianships_on_students_id"
  end

  create_table "headmasters", force: :cascade do |t|
    t.bigint "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_headmasters_on_school_id"
  end

  create_table "marks", force: :cascade do |t|
    t.bigint "students_id"
    t.bigint "subject_id"
    t.bigint "school_year_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_year_id"], name: "index_marks_on_school_year_id"
    t.index ["students_id"], name: "index_marks_on_students_id"
    t.index ["subject_id"], name: "index_marks_on_subject_id"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "remarks", force: :cascade do |t|
    t.bigint "students_id"
    t.bigint "school_year_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_year_id"], name: "index_remarks_on_school_year_id"
    t.index ["students_id"], name: "index_remarks_on_students_id"
  end

  create_table "school_years", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schools", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.bigint "school_id", null: false
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_students_on_parent_id"
    t.index ["school_id"], name: "index_students_on_school_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
