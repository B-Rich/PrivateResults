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

ActiveRecord::Schema.define(version: 20140512163537) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "infection_tests", force: true do |t|
    t.string   "name"
    t.integer  "infection_id"
    t.integer  "visit_id"
    t.uuid     "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "infection_tests", ["infection_id"], name: "index_infection_tests_on_infection_id", using: :btree
  add_index "infection_tests", ["name"], name: "index_infection_tests_on_name", using: :btree
  add_index "infection_tests", ["uuid"], name: "index_infection_tests_on_uuid", using: :btree
  add_index "infection_tests", ["visit_id"], name: "index_infection_tests_on_visit_id", using: :btree

  create_table "infections", force: true do |t|
    t.string   "name"
    t.uuid     "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", force: true do |t|
    t.string   "patient_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "uuid"
  end

  add_index "patients", ["patient_number"], name: "index_patients_on_patient_number", using: :btree
  add_index "patients", ["uuid"], name: "index_patients_on_uuid", using: :btree

  create_table "results", force: true do |t|
    t.string   "name"
    t.integer  "infection_test_id"
    t.uuid     "uuid"
    t.boolean  "positive",          default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_id"
    t.integer  "infection_id"
  end

  add_index "results", ["infection_id"], name: "index_results_on_infection_id", using: :btree
  add_index "results", ["infection_test_id"], name: "index_results_on_infection_test_id", using: :btree
  add_index "results", ["name"], name: "index_results_on_name", using: :btree
  add_index "results", ["positive"], name: "index_results_on_positive", using: :btree
  add_index "results", ["uuid"], name: "index_results_on_uuid", using: :btree
  add_index "results", ["visit_id"], name: "index_results_on_visit_id", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "visits", force: true do |t|
    t.integer  "patient_id"
    t.uuid     "uuid"
    t.date     "visited_on"
    t.string   "cosite"
    t.string   "sex"
    t.string   "race"
    t.string   "zip_code"
    t.string   "sexual_preference"
    t.string   "sexual_identity"
    t.integer  "age"
    t.integer  "partners_last_6_months_5_or_more"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visits", ["cosite"], name: "index_visits_on_cosite", using: :btree
  add_index "visits", ["patient_id"], name: "index_visits_on_patient_id", using: :btree
  add_index "visits", ["uuid"], name: "index_visits_on_uuid", using: :btree
  add_index "visits", ["visited_on"], name: "index_visits_on_visited_on", using: :btree

end
