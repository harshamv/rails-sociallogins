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

ActiveRecord::Schema.define(version: 20160419182936) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "influencer_authorizations", force: :cascade do |t|
    t.string   "provider",          null: false
    t.string   "provider_uid",      null: false
    t.text     "oauth_token",       null: false
    t.text     "meta"
    t.integer  "influencer_id",     null: false
    t.integer  "social_account_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "influencer_authorizations", ["influencer_id"], name: "index_influencer_authorizations_on_influencer_id", using: :btree
  add_index "influencer_authorizations", ["social_account_id"], name: "index_influencer_authorizations_on_social_account_id", using: :btree

  create_table "influencers", force: :cascade do |t|
    t.string   "first_name",                                   null: false
    t.string   "last_name"
    t.string   "username"
    t.string   "profile_picture_url"
    t.string   "email"
    t.string   "bio"
    t.string   "location"
    t.string   "gender"
    t.date     "date_of_birth"
    t.string   "time_zone_name",      default: "Asia/Kolkata", null: false
    t.integer  "status",              default: 1,              null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

end
