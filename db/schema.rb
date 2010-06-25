# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100625150225) do

  create_table "comments", :force => true do |t|
    t.string   "title"
    t.text     "comment_text"
    t.integer  "user_id"
    t.integer  "todo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.boolean  "active",                                                   :default => false
    t.boolean  "billable",                                                 :default => false
    t.integer  "bill_by"
    t.integer  "hourly_rate", :limit => 10, :precision => 10, :scale => 0
    t.integer  "client_id"
    t.string   "code"
    t.text     "notes"
    t.integer  "budget_by"
    t.integer  "budget",      :limit => 10, :precision => 10, :scale => 0
    t.string   "fees"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.boolean  "billable_by_default",                                              :default => false
    t.boolean  "deactivated",                                                      :default => false
    t.integer  "default_hourly_rate", :limit => 10, :precision => 10, :scale => 0
    t.boolean  "is_default",                                                       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "todos", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "due_time"
    t.integer  "task_id"
    t.integer  "user_id"
    t.boolean  "completed",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  create_table "todos_users", :id => false, :force => true do |t|
    t.integer "todo_id", :null => false
    t.integer "user_id", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
