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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140306082618) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "author_emp_id"
    t.integer  "employee_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "article_id"
    t.string   "commenter_emp_id"
    t.text     "body"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "employees", :force => true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.date     "dob"
    t.integer  "age"
    t.string   "gender"
    t.date     "doj"
    t.string   "emp_id"
    t.string   "designation"
    t.string   "manager_name"
    t.string   "manager_emp_id"
    t.string   "local_addr"
    t.string   "perm_addr"
    t.integer  "mob_no",          :limit => 8
    t.integer  "phone_no",        :limit => 8
    t.string   "pan_no"
    t.string   "off_email_id"
    t.string   "pers_email_id"
    t.string   "roles"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.date     "seperation_date"
    t.integer  "encashed_days"
  end

  create_table "holidays", :force => true do |t|
    t.date     "holiday_date"
    t.string   "holiday_day"
    t.string   "holiday_reason"
    t.string   "holiday_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "leaves", :force => true do |t|
    t.integer  "employee_id"
    t.string   "ref_id"
    t.string   "requester_emp_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "no_of_days"
    t.text     "request_remarks"
    t.date     "request_date"
    t.string   "approver_emp_id"
    t.string   "status"
    t.text     "action_remarks"
    t.text     "admin_comments"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "leave_type"
    t.date     "action_date"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "hashed_password"
    t.string   "email"
    t.string   "salt"
    t.integer  "employee_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
