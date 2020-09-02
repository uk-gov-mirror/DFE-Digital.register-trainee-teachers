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

ActiveRecord::Schema.define(version: 2020_09_01_113117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "trainees", force: :cascade do |t|
    t.text "trainee_id"
    t.text "first_names"
    t.text "last_name"
    t.text "gender"
    t.date "date_of_birth"
    t.text "nationality"
    t.text "ethnicity"
    t.text "disability"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "a_level_1_subject"
    t.text "a_level_1_grade"
    t.text "a_level_2_subject"
    t.text "a_level_2_grade"
    t.text "a_level_3_subject"
    t.text "a_level_3_grade"
    t.text "degree_subject"
    t.text "degree_class"
    t.text "degree_institution"
    t.text "degree_type"
    t.text "ske"
    t.boolean "previous_qts"
  end

end
