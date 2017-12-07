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

ActiveRecord::Schema.define(version: 20171112070333) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: :cascade do |t|
    t.integer  "match_id",               limit: 8
    t.string   "queue"
    t.string   "region"
    t.string   "season"
    t.datetime "match_creation"
    t.integer  "match_duration"
    t.string   "match_mode"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "first_blood"
    t.string   "first_tower"
    t.string   "first_inhibitor"
    t.string   "first_baron"
    t.string   "first_dragon"
    t.string   "first_rift_herald"
    t.integer  "red_tower_kills"
    t.integer  "red_inhibitor_kills"
    t.integer  "red_baron_kills"
    t.integer  "red_dragon_kills"
    t.integer  "red_vilemaw_kills"
    t.integer  "red_rift_herald_kills"
    t.integer  "blue_tower_kills"
    t.integer  "blue_inhibitor_kills"
    t.integer  "blue_baron_kills"
    t.integer  "blue_dragon_kills"
    t.integer  "blue_vilemaw_kills"
    t.integer  "blue_rift_herald_kills"
    t.string   "match_type"
    t.integer  "queue_id"
    t.datetime "synced_at"
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "match_id"
    t.integer  "participant_id",                             limit: 8
    t.integer  "account_id",                                 limit: 8
    t.string   "lane"
    t.string   "role"
    t.string   "team_id"
    t.boolean  "winner"
    t.integer  "champion_id"
    t.string   "champion"
    t.integer  "kills"
    t.integer  "deaths"
    t.integer  "assists"
    t.integer  "largest_killing_spree"
    t.integer  "largest_multi_kill"
    t.integer  "killing_sprees"
    t.integer  "double_kills"
    t.integer  "triple_kills"
    t.integer  "quadra_kills"
    t.integer  "penta_kills"
    t.integer  "unreal_kills"
    t.integer  "longest_time_spent_living"
    t.integer  "total_damage_dealt"
    t.integer  "magic_damage_dealt"
    t.integer  "physical_damage_dealt"
    t.integer  "magic_damage_dealt_to_champions"
    t.integer  "physical_damage_dealt_to_champions"
    t.integer  "total_heal"
    t.integer  "total_units_healed"
    t.integer  "damage_self_mitigated"
    t.integer  "damage_dealt_to_objectives"
    t.integer  "damage_dealt_to_turrets"
    t.integer  "vision_score"
    t.integer  "vision_wards_bought_in_game"
    t.integer  "time_ccing_others"
    t.integer  "turret_kills"
    t.integer  "inhibitor_kills"
    t.integer  "total_minions_killed"
    t.integer  "neutral_minions_killed"
    t.integer  "neutral_minions_killed_team_jungle"
    t.integer  "neutral_minions_killed_enemy_jungle"
    t.integer  "total_time_crowd_control_dealt"
    t.boolean  "first_blood_kill"
    t.boolean  "first_blood_assist"
    t.boolean  "first_tower_kill"
    t.boolean  "first_tower_assist"
    t.boolean  "first_inhibitor_kill"
    t.boolean  "first_inhibitor_assist"
    t.integer  "damage_dealt_to_champions"
    t.float    "damage_dealt_to_champions_per_min"
    t.integer  "damage_taken"
    t.float    "damage_taken_per_min"
    t.float    "damage_taken_per_min_zero_to_ten"
    t.float    "damage_taken_per_min_ten_to_twenty"
    t.float    "damage_taken_per_min_twenty_to_thirty"
    t.float    "damage_taken_per_min_thirty_to_end"
    t.float    "damage_taken_diff_per_min_zero_to_ten"
    t.float    "damage_taken_diff_per_min_ten_to_twenty"
    t.float    "damage_taken_diff_per_min_twenty_to_thirty"
    t.float    "damage_taken_diff_per_min_thirty_to_end"
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
    t.float    "cs_diff_per_min_zero_to_ten"
    t.float    "cs_diff_per_min_ten_to_twenty"
    t.float    "cs_diff_per_min_twenty_to_thirty"
    t.float    "cs_diff_per_min_thirty_to_end"
    t.float    "xp_per_min_zero_to_ten"
    t.float    "xp_per_min_ten_to_twenty"
    t.float    "xp_per_min_twenty_to_thirty"
    t.float    "xp_per_min_thirty_to_end"
    t.float    "xp_diff_per_min_zero_to_ten"
    t.float    "xp_diff_per_min_ten_to_twenty"
    t.float    "xp_diff_per_min_twenty_to_thirty"
    t.float    "xp_diff_per_min_thirty_to_end"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  add_index "participants", ["match_id"], name: "index_participants_on_match_id", using: :btree

  create_table "summoners", force: :cascade do |t|
    t.string   "name"
    t.integer  "riot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
