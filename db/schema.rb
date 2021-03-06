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

ActiveRecord::Schema.define(version: 20170822125349) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "appointments", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "request_type"
    t.text "note"
    t.date "requested_date"
    t.time "requested_time"
    t.string "location"
    t.bigint "user_id"
    t.bigint "old_salt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["old_salt_id"], name: "index_appointments_on_old_salt_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.text "comments"
    t.bigint "user_id"
    t.bigint "old_salt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["old_salt_id"], name: "index_feedbacks_on_old_salt_id"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "old_salts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.string "phone_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.json "profile_picture"
    t.string "stripe_account_id"
    t.index ["email"], name: "index_old_salts_on_email", unique: true
    t.index ["invitation_token"], name: "index_old_salts_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_old_salts_on_invitations_count"
    t.index ["invited_by_id"], name: "index_old_salts_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_old_salts_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_old_salts_on_reset_password_token", unique: true
  end

  create_table "payments", force: :cascade do |t|
    t.integer "status", default: 0
    t.decimal "amount"
    t.bigint "user_id"
    t.bigint "old_salt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["old_salt_id"], name: "index_payments_on_old_salt_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.string "phone_no"
    t.integer "user_type"
    t.json "profile_picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider"], name: "index_users_on_provider"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_users_on_uid"
  end

  add_foreign_key "appointments", "old_salts"
  add_foreign_key "appointments", "users"
  add_foreign_key "feedbacks", "old_salts"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "payments", "old_salts"
  add_foreign_key "payments", "users"
end
