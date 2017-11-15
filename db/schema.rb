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

ActiveRecord::Schema.define(version: 20171115163721) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: :cascade do |t|
    t.string "message"
    t.boolean "hired", default: false
    t.boolean "complete", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "job_id"
    t.bigint "profile_id"
    t.string "profile_username"
    t.string "job_title"
    t.index ["job_id"], name: "index_applications_on_job_id"
    t.index ["job_title"], name: "index_applications_on_job_title"
    t.index ["profile_id"], name: "index_applications_on_profile_id"
    t.index ["profile_username"], name: "index_applications_on_profile_username"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_profiles", id: false, force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "profile_id", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "comment"
    t.bigint "application_id"
    t.bigint "profile_id"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "profile_username"
    t.string "company_username"
    t.bigint "job_id"
    t.index ["application_id"], name: "index_comments_on_application_id"
    t.index ["company_id"], name: "index_comments_on_company_id"
    t.index ["company_username"], name: "index_comments_on_company_username"
    t.index ["job_id"], name: "index_comments_on_job_id"
    t.index ["profile_id"], name: "index_comments_on_profile_id"
    t.index ["profile_username"], name: "index_comments_on_profile_username"
  end

  create_table "companies", force: :cascade do |t|
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
    t.string "name"
    t.string "username"
    t.string "address"
    t.integer "zip_code"
    t.string "city"
    t.string "org_number"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact"
    t.string "invoice_address"
    t.index ["email"], name: "index_companies_on_email", unique: true
    t.index ["reset_password_token"], name: "index_companies_on_reset_password_token", unique: true
  end

  create_table "invoices", force: :cascade do |t|
    t.string "quantity"
    t.string "unit"
    t.integer "amount"
    t.date "first_day"
    t.date "last_day"
    t.text "description"
    t.string "user_reference"
    t.string "company_reference"
    t.integer "terms", default: 30
    t.boolean "paid", default: false
    t.boolean "active", default: false
    t.bigint "user_id"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "application_id"
    t.integer "job_id"
    t.integer "profile_id"
    t.string "profile_username"
    t.boolean "post", default: false
    t.text "feedback"
    t.index ["application_id"], name: "index_invoices_on_application_id"
    t.index ["company_id"], name: "index_invoices_on_company_id"
    t.index ["job_id"], name: "index_invoices_on_job_id"
    t.index ["profile_id"], name: "index_invoices_on_profile_id"
    t.index ["profile_username"], name: "index_invoices_on_profile_username"
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "requirement"
    t.string "category"
    t.string "city"
    t.string "budget"
    t.date "deadline"
    t.string "duration"
    t.integer "hour_week"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.string "company_city"
    t.string "company_username"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["company_city"], name: "index_jobs_on_company_city"
    t.index ["company_id"], name: "index_jobs_on_company_id"
    t.index ["company_username"], name: "index_jobs_on_company_username"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "username"
    t.string "title"
    t.text "description"
    t.string "skill"
    t.string "rate"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bank"
    t.string "clear_nr"
    t.string "account_nr"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "applications", "jobs"
  add_foreign_key "applications", "profiles"
  add_foreign_key "comments", "applications"
  add_foreign_key "comments", "companies"
  add_foreign_key "comments", "jobs"
  add_foreign_key "comments", "profiles"
  add_foreign_key "invoices", "companies"
  add_foreign_key "invoices", "users"
  add_foreign_key "jobs", "companies"
  add_foreign_key "profiles", "users"
end
