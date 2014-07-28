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

ActiveRecord::Schema.define(version: 20140705194226) do

  create_table "admin_course_requirement_filleds", force: true do |t|
    t.boolean  "prerequisites"
    t.boolean  "corequisites"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "prerequisite_read"
    t.text     "corequisite_read"
  end

  add_index "admin_course_requirement_filleds", ["course_id"], name: "index_admin_course_requirement_filleds_on_course_id", using: :btree

  create_table "badges", force: true do |t|
    t.string   "name"
    t.string   "desciption"
    t.integer  "point"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogs", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buisness_times", force: true do |t|
    t.integer  "day_id"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "buisness_timeable_id"
    t.string   "buisness_timeable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "buisness_times", ["day_id"], name: "index_buisness_times_on_day_id", using: :btree

  create_table "contactus_forms", force: true do |t|
    t.string   "email"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_courses", force: true do |t|
    t.string   "name"
    t.integer  "subject_id"
    t.integer  "code"
    t.text     "description"
    t.integer  "hours"
    t.float    "credit",          limit: 24
    t.integer  "prerequisite_id"
    t.integer  "corequisite_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "part"
  end

  add_index "course_courses", ["corequisite_id"], name: "index_courses_on_corequisite_id", using: :btree
  add_index "course_courses", ["prerequisite_id"], name: "index_courses_on_prerequisite_id", using: :btree
  add_index "course_courses", ["subject_id"], name: "index_courses_on_subject_id", using: :btree

  create_table "course_courses_program_groups", id: false, force: true do |t|
    t.integer "group_id"
    t.integer "course_id"
  end

  create_table "course_courses_university_years", force: true do |t|
    t.integer "course_id"
    t.integer "university_year_id"
  end

  add_index "course_courses_university_years", ["course_id"], name: "index_course_courses_university_years_on_course_course_id", using: :btree
  add_index "course_courses_university_years", ["university_year_id"], name: "index_course_courses_university_years_on_university_year_id", using: :btree

  create_table "course_exprs", force: true do |t|
    t.integer  "node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_exprs", ["node_id"], name: "index_course_exprs_on_node_id", using: :btree

  create_table "course_grading_system_entities", force: true do |t|
    t.string   "name"
    t.float    "value",             limit: 24
    t.boolean  "pass"
    t.boolean  "pass_core"
    t.integer  "grading_system_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "min_score",         limit: 24
  end

  add_index "course_grading_system_entities", ["grading_system_id"], name: "index_course_grading_system_entities_on_grading_system_id", using: :btree

  create_table "course_grading_systems", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_node_childrens", force: true do |t|
    t.integer "course_node_id"
    t.integer "children_id"
  end

  create_table "course_nodes", force: true do |t|
    t.string   "operation"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_nodes", ["course_id"], name: "index_course_nodes_on_course_id", using: :btree

  create_table "course_rating_criteria", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_ratings", force: true do |t|
    t.integer  "criteria_id"
    t.integer  "review_id"
    t.float    "score",       limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_ratings", ["criteria_id"], name: "index_course_ratings_on_criteria_id", using: :btree
  add_index "course_ratings", ["review_id"], name: "index_course_ratings_on_review_id", using: :btree

  create_table "course_reviews", force: true do |t|
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
  end

  add_index "course_reviews", ["course_id"], name: "index_course_reviews_on_course_id", using: :btree
  add_index "course_reviews", ["user_id"], name: "index_course_reviews_on_user_id", using: :btree

  create_table "course_scenarios", force: true do |t|
    t.boolean  "main"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_scenarios", ["user_id"], name: "index_course_scenarios_on_user_id", using: :btree

  create_table "course_scenarios_program_versions", force: true do |t|
    t.integer "version_id"
    t.integer "scenario_id"
  end

  create_table "course_schedules", force: true do |t|
    t.integer  "year"
    t.integer  "semester_id"
    t.integer  "course_id"
    t.integer  "capacity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_schedules", ["course_id"], name: "index_course_schedules_on_course_id", using: :btree
  add_index "course_schedules", ["semester_id"], name: "index_course_schedules_on_semester_id", using: :btree

  create_table "course_semesters", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
  end

  create_table "course_subject_course_lists", force: true do |t|
    t.integer  "subject_id"
    t.integer  "level"
    t.string   "operation"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_subject_course_lists", ["group_id"], name: "index_course_subject_course_lists_on_group_id", using: :btree
  add_index "course_subject_course_lists", ["subject_id"], name: "index_course_subject_course_lists_on_subject_id", using: :btree

  create_table "course_subject_requirement_nodes", force: true do |t|
    t.integer  "amount"
    t.integer  "subject_id"
    t.integer  "level"
    t.integer  "node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_subject_requirement_nodes", ["node_id"], name: "index_course_subject_requirement_nodes_on_node_id", using: :btree
  add_index "course_subject_requirement_nodes", ["subject_id"], name: "index_course_subject_requirement_nodes_on_subject_id", using: :btree

  create_table "course_subjects", force: true do |t|
    t.string   "name"
    t.string   "longname"
    t.integer  "university_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_subjects", ["university_id"], name: "index_course_subjects_on_university_id", using: :btree

  create_table "days", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faculties", force: true do |t|
    t.string   "name"
    t.string   "website"
    t.integer  "university_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_name"
  end

  add_index "faculties", ["university_id"], name: "index_faculties_on_university_id", using: :btree

  create_table "fgc_grades", force: true do |t|
    t.string   "name"
    t.float    "value",      limit: 24
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fgc_grades", ["group_id"], name: "index_fgc_grades_on_group_id", using: :btree

  create_table "fgc_groups", force: true do |t|
    t.integer  "prediction_id"
    t.boolean  "simple",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fgc_percents", force: true do |t|
    t.float    "value",      limit: 24
    t.integer  "group_id"
    t.integer  "scheme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fgc_percents", ["group_id"], name: "index_fgc_percents_on_group_id", using: :btree
  add_index "fgc_percents", ["scheme_id"], name: "index_fgc_percents_on_scheme_id", using: :btree

  create_table "fgc_predictions", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fgc_schemes", force: true do |t|
    t.integer  "prediction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fgc_schemes", ["prediction_id"], name: "index_fgc_schemes_on_prediction_id", using: :btree

  create_table "issue_comments", force: true do |t|
    t.integer  "issue_id"
    t.integer  "commenter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "issue_comments", ["commenter_id"], name: "index_issue_comments_on_commenter_id", using: :btree
  add_index "issue_comments", ["issue_id"], name: "index_issue_comments_on_issue_id", using: :btree

  create_table "issue_issues", force: true do |t|
    t.string   "title"
    t.integer  "reporter_id"
    t.integer  "assignee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",      default: 0
  end

  add_index "issue_issues", ["assignee_id"], name: "index_issue_issues_on_assignee_id", using: :btree
  add_index "issue_issues", ["reporter_id"], name: "index_issue_issues_on_reporter_id", using: :btree

  create_table "issue_related_items", force: true do |t|
    t.integer  "issue_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "issue_related_items", ["issue_id"], name: "index_issue_related_items_on_issue_id", using: :btree
  add_index "issue_related_items", ["item_id", "item_type"], name: "index_issue_related_items_on_item_id_and_item_type", using: :btree

  create_table "program_group_restriction_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "program_group_restrictions", force: true do |t|
    t.integer  "group_id"
    t.integer  "value"
    t.integer  "type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "program_group_restrictions", ["group_id"], name: "index_program_group_restrictions_on_group_id", using: :btree
  add_index "program_group_restrictions", ["type_id"], name: "index_program_group_restrictions_on_type_id", using: :btree

  create_table "program_groups", force: true do |t|
    t.string   "name"
    t.integer  "groupparent_id"
    t.string   "groupparent_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_name"
  end

  create_table "program_groups_programs", id: false, force: true do |t|
    t.integer "program_id", null: false
    t.integer "group_id",   null: false
  end

  create_table "program_programs", force: true do |t|
    t.string   "name"
    t.integer  "type_id"
    t.integer  "faculty_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "program_programs", ["faculty_id"], name: "index_program_programs_on_faculty_id", using: :btree
  add_index "program_programs", ["type_id"], name: "index_program_programs_on_type_id", using: :btree

  create_table "program_versions", force: true do |t|
    t.integer  "program_id"
    t.integer  "start_year"
    t.integer  "end_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "program_versions", ["program_id"], name: "index_program_versions_on_program_id", using: :btree

  create_table "programs_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "rich_contents", force: true do |t|
    t.text     "text"
    t.integer  "format"
    t.integer  "contentable_id"
    t.string   "contentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rich_contents", ["contentable_id", "contentable_type"], name: "index_rich_contents_on_contentable_id_and_contentable_type", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "translations", force: true do |t|
    t.string   "locale"
    t.string   "key"
    t.text     "value"
    t.text     "interpolations"
    t.boolean  "is_proc",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "universities", force: true do |t|
    t.string   "name"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "grading_system_id"
    t.integer  "grade_system_id"
  end

  add_index "universities", ["grade_system_id"], name: "index_universities_on_grade_system_id", using: :btree
  add_index "universities", ["grading_system_id"], name: "index_universities_on_grading_system_id", using: :btree

  create_table "university_year_systems", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "university_years", force: true do |t|
    t.string   "name"
    t.integer  "order"
    t.integer  "year_system_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_advisor_students", force: true do |t|
    t.integer  "advisor_id"
    t.integer  "student_id"
    t.integer  "status",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_advisor_students", ["advisor_id"], name: "index_user_advisor_students_on_advisor_id", using: :btree
  add_index "user_advisor_students", ["student_id"], name: "index_user_advisor_students_on_student_id", using: :btree

  create_table "user_completed_courses", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "grade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "semester_id"
    t.integer  "year"
    t.boolean  "advanced_standing", default: false
  end

  add_index "user_completed_courses", ["course_id"], name: "index_user_completed_courses_on_course_id", using: :btree
  add_index "user_completed_courses", ["grade_id"], name: "index_user_completed_courses_on_grade_id", using: :btree
  add_index "user_completed_courses", ["semester_id"], name: "index_user_completed_courses_on_semester_id", using: :btree
  add_index "user_completed_courses", ["user_id"], name: "index_user_completed_courses_on_user_id", using: :btree

  create_table "user_emails", force: true do |t|
    t.string   "email"
    t.boolean  "validated"
    t.boolean  "primary"
    t.integer  "university_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_emails", ["university_id"], name: "index_user_emails_on_university_id", using: :btree
  add_index "user_emails", ["user_id"], name: "index_user_emails_on_user_id", using: :btree

  create_table "user_taking_courses", force: true do |t|
    t.integer  "course_scenario_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "semester_id"
    t.integer  "year"
  end

  add_index "user_taking_courses", ["course_id"], name: "index_user_taking_courses_on_course_id", using: :btree
  add_index "user_taking_courses", ["course_scenario_id"], name: "index_user_taking_courses_on_course_scenario_id", using: :btree
  add_index "user_taking_courses", ["semester_id"], name: "index_user_taking_courses_on_semester_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                     default: "", null: false
    t.string   "encrypted_password",        default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "university_id"
    t.integer  "faculty_id"
    t.integer  "advanced_standing_credits", default: 0
    t.string   "first_name"
    t.string   "last_name"
    t.string   "type"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["faculty_id"], name: "index_users_on_faculty_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["university_id"], name: "index_users_on_university_id", using: :btree

  create_table "users_courses_recommendation_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_courses_recommendations", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.float    "score",      limit: 24
    t.integer  "type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users_courses_recommendations", ["course_id"], name: "index_users_courses_recommendations_on_course_id", using: :btree
  add_index "users_courses_recommendations", ["user_id"], name: "index_users_courses_recommendations_on_user_id", using: :btree

end
