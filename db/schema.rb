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

ActiveRecord::Schema.define(version: 20140617175757) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversations", force: true do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "familiarities", force: true do |t|
    t.string   "key_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profile_ids"
    t.string   "description"
  end

  create_table "familiarities_profiles", id: false, force: true do |t|
    t.integer "familiarity_id", null: false
    t.integer "profile_id",     null: false
  end

  create_table "notifications", force: true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "notifications", ["conversation_id"], name: "index_notifications_on_conversation_id", using: :btree

  create_table "plans", force: true do |t|
    t.integer  "price"
    t.string   "plan_type"
    t.string   "plan_level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "profile_categories", force: true do |t|
    t.string   "key_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profile_categories", ["key_name"], name: "index_profile_categories_on_key_name", using: :btree

  create_table "profile_sub_categories", force: true do |t|
    t.string   "key_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  add_index "profile_sub_categories", ["key_name"], name: "index_profile_sub_categories_on_key_name", using: :btree

  create_table "profiles", force: true do |t|
    t.string   "company_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "contact_name"
    t.string   "contact_email_address"
    t.string   "contact_phone_number"
    t.string   "short_description"
    t.string   "category"
    t.string   "sub_category"
    t.string   "business_plan"
    t.string   "state"
    t.string   "city"
    t.string   "company_image"
    t.string   "status",                                default: "not_approved"
    t.boolean  "published",                             default: false
    t.string   "long_description"
    t.string   "user_hospitality_experience"
    t.string   "user_management_experience"
    t.string   "user_current_position"
    t.string   "user_highest_position"
    t.string   "address"
    t.string   "investment_amount"
    t.string   "partner_type"
    t.string   "business_experience"
    t.string   "previous_restaurant_status"
    t.string   "investment_type"
    t.string   "seat_number"
    t.integer  "assets_liquid_cents"
    t.string   "assets_liquid_currency",                default: "USD",          null: false
    t.integer  "assets_marketable_securities_cents"
    t.string   "assets_marketable_securities_currency", default: "USD",          null: false
    t.integer  "assets_real_estate_cents"
    t.string   "assets_real_estate_currency",           default: "USD",          null: false
    t.integer  "assets_personal_cents"
    t.string   "assets_personal_currency",              default: "USD",          null: false
    t.integer  "assets_notes_receivable_cents"
    t.string   "assets_notes_receivable_currency",      default: "USD",          null: false
    t.integer  "assets_business_holdings_cents"
    t.string   "assets_business_holdings_currency",     default: "USD",          null: false
    t.integer  "assets_total_cents"
    t.string   "assets_total_currency",                 default: "USD",          null: false
    t.integer  "liabilities_notes_payable_cents"
    t.string   "liabilities_notes_payable_currency",    default: "USD",          null: false
    t.integer  "liabilities_accounts_payable_cents"
    t.string   "liabilities_accounts_payable_currency", default: "USD",          null: false
    t.integer  "liabilities_auto_loans_cents"
    t.string   "liabilities_auto_loans_currency",       default: "USD",          null: false
    t.integer  "liabilities_mortgage_cents"
    t.string   "liabilities_mortgage_currency",         default: "USD",          null: false
    t.integer  "liabilities_other_cents"
    t.string   "liabilities_other_currency",            default: "USD",          null: false
    t.integer  "liabilities_total_cents"
    t.string   "liabilities_total_currency",            default: "USD",          null: false
    t.integer  "net_worth_cents"
    t.string   "net_worth_currency",                    default: "USD",          null: false
    t.string   "profit_loss_statement"
    t.string   "familiarity_ids"
    t.boolean  "user_serv_safe_certified"
    t.boolean  "user_has_criminal_record"
    t.string   "user_criminal_record_explanation"
    t.boolean  "user_attended_culinary_school"
    t.string   "user_culinary_school_name"
    t.boolean  "user_graduated_culinary_school"
    t.string   "user_professional_awards"
    t.boolean  "user_current_restaurant_owner"
    t.boolean  "user_previous_restaurant_owner"
    t.string   "user_culinary_school_years_attended"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "receipts", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "receipts", ["notification_id"], name: "index_receipts_on_notification_id", using: :btree

  create_table "subscriptions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stripe_customer_token"
    t.string   "email"
    t.integer  "plan_id"
    t.integer  "user_id"
    t.string   "last_four"
    t.string   "card_type"
    t.string   "card_expiration"
    t.date     "next_bill_on"
  end

  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                   default: "",    null: false
    t.string   "encrypted_password",      default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "user_type"
    t.string   "username"
    t.integer  "conversations_initiated", default: 0
    t.boolean  "admin",                   default: false
    t.boolean  "active_subscription",     default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

  add_foreign_key "notifications", "conversations", name: "notifications_on_conversation_id"

  add_foreign_key "receipts", "notifications", name: "receipts_on_notification_id"

end
