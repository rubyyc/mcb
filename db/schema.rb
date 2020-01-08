# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_03_060201) do

  create_table "locations", force: :cascade do |t|
    t.integer "teacher_id"
    t.time "start_time"
    t.time "end_time"
    t.integer "weekday"
    t.integer "place"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "scheduled_students", force: :cascade do |t|
    t.integer "status"
    t.integer "student_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_scheduled_students_on_student_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.text "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "student_id"
    t.integer "teacher_id"
    t.integer "location_id"
    t.integer "scheduled_student_id"
    t.integer "scheduled_times"
    t.datetime "next_start_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status"
  end

  create_table "students", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "school_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["name"], name: "index_students_on_name", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role"
    t.string "school_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "approved", default: false, null: false
    t.index ["approved"], name: "index_teachers_on_approved"
    t.index ["email"], name: "index_teachers_on_email", unique: true
    t.index ["name"], name: "index_teachers_on_name"
    t.index ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true
  end

end
