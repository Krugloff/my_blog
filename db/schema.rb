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

ActiveRecord::Schema.define(:version => 20130329140255) do

  create_table "accounts", :force => true do |t|
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "uid"
  end

  add_index "accounts", ["uid"], :name => "index_accounts_on_uid"
  add_index "accounts", ["user_id"], :name => "index_accounts_on_user_id"

  create_table "articles", :force => true do |t|
    t.string   "title",      :limit => 42, :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.text     "body",                     :null => false
    t.integer  "user_id"
  end

  create_table "comments", :force => true do |t|
    t.text     "body",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "article_id"
    t.integer  "user_id"
    t.integer  "parent_id"
  end

  add_index "comments", ["parent_id"], :name => "index_comments_on_parent_id"

  create_table "users", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  add_index "users", ["name"], :name => "index_users_on_name"

end
