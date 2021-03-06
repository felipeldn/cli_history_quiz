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

ActiveRecord::Schema.define(version: 2019_08_23_094128) do

  create_table "questions", force: :cascade do |t|
    t.string "question"
    t.string "option_a"
    t.string "option_b"
    t.string "option_c"
    t.string "correct_answer"
    t.string "correct_answer_response"
    t.string "wrong_answer_response"
  end

  create_table "user_questions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "question_id"
    t.string "user_answer"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.integer "score", default: 0
  end

end
