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

ActiveRecord::Schema.define(:version => 20110105100949) do

  create_table "chains", :force => true do |t|
    t.string   "anchor"
    t.string   "started_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "votes_count", :default => 0
  end

  create_table "choices", :force => true do |t|
    t.string   "term"
    t.integer  "rank"
    t.float    "percent",     :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "chain_id",                     :null => false
    t.string   "link"
    t.string   "label"
    t.integer  "votes_count", :default => 0
  end

  create_table "tweet_choices", :force => true do |t|
    t.integer  "tweet_id",   :null => false
    t.integer  "choice_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweet_choices", ["choice_id"], :name => "index_tweet_choices_on_choice_id"
  add_index "tweet_choices", ["tweet_id", "choice_id"], :name => "index_tweet_choices_on_tweet_id_and_choice_id", :unique => true
  add_index "tweet_choices", ["tweet_id"], :name => "index_tweet_choices_on_tweet_id"

  create_table "tweets", :force => true do |t|
    t.string   "twitter_id",                    :null => false
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "chain_id"
    t.integer  "voter_id",                      :null => false
    t.boolean  "scored",     :default => false
    t.datetime "tweeted_at"
  end

  create_table "voters", :force => true do |t|
    t.string   "screen_name",       :null => false
    t.string   "name"
    t.string   "twitter_id",        :null => false
    t.string   "profile_image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "voters", ["screen_name"], :name => "index_voters_on_screen_name"
  add_index "voters", ["twitter_id"], :name => "index_voters_on_twitter_id", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "voter_id",   :null => false
    t.integer  "tweet_id",   :null => false
    t.integer  "choice_id",  :null => false
    t.integer  "chain_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["voter_id", "chain_id", "choice_id"], :name => "index_votes_on_voter_id_and_chain_id_and_choice_id", :unique => true

end
