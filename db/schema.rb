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

ActiveRecord::Schema.define(version: 20130807173429) do

  create_table "badges_sashes", force: true do |t|
    t.integer "badge_id"
    t.integer "sash_id"
    t.boolean "notified_user", default: false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id", using: :btree
  add_index "badges_sashes", ["badge_id"], name: "index_badges_sashes_on_badge_id", using: :btree
  add_index "badges_sashes", ["sash_id"], name: "index_badges_sashes_on_sash_id", using: :btree

  create_table "course_exprs", force: true do |t|
    t.integer "node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_exprs", ["node_id"], name: "index_course_exprs_on_node_id", using: :btree

  create_table "course_grading_system_entities", force: true do |t|
    t.string "name"
    t.float "value"
    t.boolean "pass"
    t.boolean "pass_core"
    t.integer "system_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_grading_system_entities", ["system_id"], name: "index_course_grading_system_entities_on_system_id", using: :btree

  create_table "course_grading_systems", force: true do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_nodes", force: true do |t|
    t.string "operation"
    t.integer "parent_id"
    t.integer "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_nodes", ["course_id"], name: "index_course_nodes_on_course_id", using: :btree
  add_index "course_nodes", ["parent_id"], name: "index_course_nodes_on_parent_id", using: :btree

  create_table "course_subjects", force: true do |t|
    t.string "name"
    t.string "longname"
    t.integer "university_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_subjects", ["university_id"], name: "index_course_subjects_on_university_id", using: :btree

  create_table "courses", force: true do |t|
    t.string "name"
    t.integer "subject_id"
    t.integer "code"
    t.text "description"
    t.integer "hours"
    t.integer "credit"
    t.integer "prerequisite_id"
    t.integer "corequisite_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["corequisite_id"], name: "index_courses_on_corequisite_id", using: :btree
  add_index "courses", ["prerequisite_id"], name: "index_courses_on_prerequisite_id", using: :btree
  add_index "courses", ["subject_id"], name: "index_courses_on_subject_id", using: :btree

  create_table "courses_program_groups", id: false, force: true do |t|
    t.integer "program_group_id"
    t.integer "course_id"
  end

  create_table "faculties", force: true do |t|
    t.string "name"
    t.string "website"
    t.integer "university_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "faculties", ["university_id"], name: "index_faculties_on_university_id", using: :btree

  create_table "merit_actions", force: true do |t|
    t.integer "user_id"
    t.string "action_method"
    t.integer "action_value"
    t.boolean "had_errors", default: false
    t.string "target_model"
    t.integer "target_id"
    t.boolean "processed", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", force: true do |t|
    t.integer "action_id"
    t.string "related_change_type"
    t.integer "related_change_id"
    t.string "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: true do |t|
    t.integer "score_id"
    t.integer "num_points", default: 0
    t.string "log"
    t.datetime "created_at"
  end

  create_table "merit_scores", force: true do |t|
    t.integer "sash_id"
    t.string "category", default: "default"
  end

  create_table "program_groups", force: true do |t|
    t.string "name"
    t.string "restriction"
    t.integer "value"
    t.integer "groupparent_id"
    t.string "groupparent_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", force: true do |t|
    t.string "name"
    t.integer "type_id"
    t.integer "faculty_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "programs", ["faculty_id"], name: "index_programs_on_faculty_id", using: :btree
  add_index "programs", ["type_id"], name: "index_programs_on_type_id", using: :btree

  create_table "programs_types", force: true do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs_users", force: true do |t|
    t.integer "program_id"
    t.integer "user_id"
  end

  create_table "rails_admin_histories", force: true do |t|
    t.text "message"
    t.string "username"
    t.integer "item"
    t.string "table"
    t.integer "month", limit: 2
    t.integer "year", limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "roles", force: true do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "sashes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "translations", force: true do |t|
    t.string "locale"
    t.string "key"
    t.text "value"
    t.text "interpolations"
    t.boolean "is_proc", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "universities", force: true do |t|
    t.string "name"
    t.string "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "grading_system_id"
  end

  add_index "universities", ["grading_system_id"], name: "index_universities_on_grading_system_id", using: :btree

  create_table "user_completed_courses", force: true do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.integer "grade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_completed_courses", ["course_id"], name: "index_user_completed_courses_on_course_id", using: :btree
  add_index "user_completed_courses", ["grade_id"], name: "index_user_completed_courses_on_grade_id", using: :btree
  add_index "user_completed_courses", ["user_id"], name: "index_user_completed_courses_on_user_id", using: :btree

  create_table "user_emails", force: true do |t|
    t.string "email"
    t.boolean "validated"
    t.boolean "primary"
    t.integer "university_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_emails", ["university_id"], name: "index_user_emails_on_university_id", using: :btree
  add_index "user_emails", ["user_id"], name: "index_user_emails_on_user_id", using: :btree

  create_table "user_taking_courses", force: true do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_taking_courses", ["course_id"], name: "index_user_taking_courses_on_course_id", using: :btree
  add_index "user_taking_courses", ["user_id"], name: "index_user_taking_courses_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "university_id"
    t.integer "faculty_id"
    t.integer "sash_id"
    t.integer "level", default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["faculty_id"], name: "index_users_on_faculty_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["university_id"], name: "index_users_on_university_id", using: :btree

end
