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

ActiveRecord::Schema.define(version: 20170125072827) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: :cascade do |t|
    t.integer  "summoner_id"
    t.string   "champion"
    t.string   "lane"
    t.integer  "match_id",                                       limit: 8
    t.string   "queue"
    t.string   "region"
    t.string   "season"
    t.datetime "match_creation"
    t.integer  "match_duration"
    t.string   "match_mode"
    t.boolean  "winner"
    t.integer  "kills"
    t.integer  "deaths"
    t.integer  "assists"
    t.integer  "damage_dealt_to_champions"
    t.float    "damage_dealt_to_champions_per_min"
    t.integer  "damage_taken"
    t.float    "damage_taken_per_min"
    t.float    "damage_taken_per_min_zero_to_ten"
    t.float    "damage_taken_per_min_ten_to_twenty"
    t.float    "damage_taken_per_min_twenty_to_thirty"
    t.float    "damage_taken_per_min_thirty_to_end"
    t.integer  "gold"
    t.float    "gold_per_min"
    t.float    "gold_per_min_zero_to_ten"
    t.float    "gold_per_min_ten_to_twenty"
    t.float    "gold_per_min_twenty_to_thirty"
    t.float    "gold_per_min_thirty_to_end"
    t.integer  "cs"
    t.float    "cs_per_min_zero_to_ten"
    t.float    "cs_per_min_ten_to_twenty"
    t.float    "cs_per_min_twenty_to_thirty"
    t.float    "cs_per_min_thirty_to_end"
    t.float    "xp_per_min_zero_to_ten"
    t.float    "xp_per_min_ten_to_twenty"
    t.float    "xp_per_min_twenty_to_thirty"
    t.float    "xp_per_min_thirty_to_end"
    t.integer  "opponent_kills"
    t.integer  "opponent_deaths"
    t.integer  "opponent_assists"
    t.integer  "opponent_damage_dealt_to_champions"
    t.float    "opponent_damage_dealt_to_champions_per_min"
    t.integer  "opponent_damage_taken"
    t.float    "opponent_damage_taken_per_min"
    t.float    "opponent_damage_taken_per_min_zero_to_ten"
    t.float    "opponent_damage_taken_per_min_ten_to_twenty"
    t.float    "opponent_damage_taken_per_min_twenty_to_thirty"
    t.float    "opponent_damage_taken_per_min_thirty_to_end"
    t.integer  "opponent_gold"
    t.float    "opponent_gold_per_min"
    t.float    "opponent_gold_per_min_zero_to_ten"
    t.float    "opponent_gold_per_min_ten_to_twenty"
    t.float    "opponent_gold_per_min_twenty_to_thirty"
    t.float    "opponent_gold_per_min_thirty_to_end"
    t.integer  "opponent_cs"
    t.float    "opponent_cs_per_min_zero_to_ten"
    t.float    "opponent_cs_per_min_ten_to_twenty"
    t.float    "opponent_cs_per_min_twenty_to_thirty"
    t.float    "opponent_cs_per_min_thirty_to_end"
    t.float    "opponent_xp_per_min_zero_to_ten"
    t.float    "opponent_xp_per_min_ten_to_twenty"
    t.float    "opponent_xp_per_min_twenty_to_thirty"
    t.float    "opponent_xp_per_min_thirty_to_end"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  create_table "summoners", force: :cascade do |t|
    t.string   "name"
    t.integer  "riot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
