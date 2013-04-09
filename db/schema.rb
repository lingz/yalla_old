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

ActiveRecord::Schema.define(:version => 20130409193734) do

  create_table "attending_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "calendars", :force => true do |t|
    t.string   "code"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "redirect_uri"
    t.string   "access_token"
    t.string   "refresh_token"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "calendar_id"
    t.datetime "last_update"
    t.datetime "last_cleanup"
    t.integer  "calls"
  end

  create_table "comments", :force => true do |t|
    t.text     "description"
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "emails", :force => true do |t|
    t.string   "address"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.text     "name"
    t.integer  "user_id"
    t.text     "location"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "description"
    t.text     "image"
    t.string   "status"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "unique_id"
    t.string   "ids"
    t.integer  "user_event_id"
    t.text     "blurb"
    t.integer  "filter"
  end

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.text     "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_events", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "email"
    t.text     "name"
    t.boolean  "status"
  end

  create_table "users", :force => true do |t|
    t.text     "name"
    t.text     "display_image"
    t.integer  "school_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "email"
    t.string   "ids"
    t.string   "netID"
    t.string   "nyu_class"
    t.text     "nyu_token"
    t.string   "secondary_email"
    t.string   "remember_token"
    t.integer  "visits"
    t.integer  "state"
  end

end
