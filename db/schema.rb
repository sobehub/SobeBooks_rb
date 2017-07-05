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

ActiveRecord::Schema.define(version: 20170517164842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.string   "reference"
    t.string   "notes"
    t.decimal  "amount"
    t.decimal  "lastpaid"
    t.decimal  "totalpaid"
    t.string   "status"
    t.integer  "user_id"
    t.integer  "vendor_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.decimal  "balance"
    t.date     "lastpayment"
    t.date     "transaction_date"
    t.date     "duedate"
    t.integer  "setup_id"
  end

  add_index "bills", ["user_id"], name: "index_bills_on_user_id", using: :btree
  add_index "bills", ["vendor_id"], name: "index_bills_on_vendor_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "company_name"
    t.string   "email"
    t.string   "phone"
    t.string   "identifier"
    t.string   "reference"
    t.string   "notes"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "status"
    t.integer  "setup_id"
  end

  add_index "clients", ["setup_id"], name: "index_clients_on_setup_id", using: :btree
  add_index "clients", ["user_id"], name: "index_clients_on_user_id", using: :btree

  create_table "clienttransactions", force: :cascade do |t|
    t.integer  "setup_id"
    t.integer  "client_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
    t.date     "transaction_date"
    t.date     "duedate"
  end

  add_index "clienttransactions", ["client_id"], name: "index_clienttransactions_on_client_id", using: :btree
  add_index "clienttransactions", ["setup_id"], name: "index_clienttransactions_on_setup_id", using: :btree
  add_index "clienttransactions", ["user_id"], name: "index_clienttransactions_on_user_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.string   "bill_to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "client_id"
    t.string   "reference"
    t.decimal  "amount"
    t.decimal  "balance"
    t.string   "notes"
    t.date     "lastpayment"
    t.decimal  "totalpaid"
    t.string   "status"
    t.date     "duedate"
    t.date     "transaction_date"
  end

  add_index "invoices", ["client_id"], name: "index_invoices_on_client_id", using: :btree
  add_index "invoices", ["user_id"], name: "index_invoices_on_user_id", using: :btree

  create_table "line_items", force: :cascade do |t|
    t.decimal  "price"
    t.string   "description"
    t.integer  "quantity"
    t.integer  "invoices_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "pg_search_documents", ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree

  create_table "setups", force: :cascade do |t|
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "setuptype"
    t.string   "typeofsetup"
  end

  add_index "setups", ["user_id"], name: "index_setups_on_user_id", using: :btree

  create_table "transactionbills", force: :cascade do |t|
    t.integer  "bill_id"
    t.integer  "vendortransaction_id"
    t.decimal  "amount"
    t.decimal  "balance"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "reference_no"
    t.string   "Cash_type"
  end

  add_index "transactionbills", ["bill_id"], name: "index_transactionbills_on_bill_id", using: :btree
  add_index "transactionbills", ["vendortransaction_id"], name: "index_transactionbills_on_vendortransaction_id", using: :btree

  create_table "transactioninvoices", force: :cascade do |t|
    t.integer  "clienttransaction_id"
    t.integer  "invoice_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.decimal  "balance"
    t.decimal  "amount"
    t.integer  "reference_no"
    t.string   "Cash_type"
    t.integer  "user_id"
  end

  add_index "transactioninvoices", ["clienttransaction_id"], name: "index_transactioninvoices_on_clienttransaction_id", using: :btree
  add_index "transactioninvoices", ["invoice_id"], name: "index_transactioninvoices_on_invoice_id", using: :btree
  add_index "transactioninvoices", ["user_id"], name: "index_transactioninvoices_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "notes"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vendors", force: :cascade do |t|
    t.string   "name"
    t.string   "company_name"
    t.string   "email"
    t.string   "phone"
    t.string   "identifier"
    t.string   "reference"
    t.string   "notes"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "status"
    t.integer  "setup_id"
  end

  add_index "vendors", ["setup_id"], name: "index_vendors_on_setup_id", using: :btree
  add_index "vendors", ["user_id"], name: "index_vendors_on_user_id", using: :btree

  create_table "vendortransactions", force: :cascade do |t|
    t.integer  "setup_id"
    t.integer  "vendor_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.date     "transaction_date"
    t.date     "duedate"
  end

  add_index "vendortransactions", ["setup_id"], name: "index_vendortransactions_on_setup_id", using: :btree
  add_index "vendortransactions", ["user_id"], name: "index_vendortransactions_on_user_id", using: :btree
  add_index "vendortransactions", ["vendor_id"], name: "index_vendortransactions_on_vendor_id", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "bills", "users"
  add_foreign_key "bills", "vendors"
  add_foreign_key "clients", "setups"
  add_foreign_key "clients", "users"
  add_foreign_key "clienttransactions", "clients"
  add_foreign_key "clienttransactions", "setups"
  add_foreign_key "clienttransactions", "users"
  add_foreign_key "invoices", "clients"
  add_foreign_key "invoices", "users"
  add_foreign_key "setups", "users"
  add_foreign_key "transactionbills", "bills"
  add_foreign_key "transactionbills", "vendortransactions"
  add_foreign_key "transactioninvoices", "clienttransactions"
  add_foreign_key "transactioninvoices", "invoices"
  add_foreign_key "transactioninvoices", "users"
  add_foreign_key "vendors", "setups"
  add_foreign_key "vendors", "users"
  add_foreign_key "vendortransactions", "setups"
  add_foreign_key "vendortransactions", "users"
  add_foreign_key "vendortransactions", "vendors"
end
