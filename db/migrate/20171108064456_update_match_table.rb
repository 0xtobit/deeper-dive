class UpdateMatchTable < ActiveRecord::Migration
  def change
    add_column :matches, :first_blood, :string
    add_column :matches, :first_tower, :string
    add_column :matches, :first_inhibitor, :string
    add_column :matches, :first_baron, :string
    add_column :matches, :first_dragon, :string
    add_column :matches, :first_rift_herald, :string
    add_column :matches, :red_tower_kills, :integer
    add_column :matches, :red_inhibitor_kills, :integer
    add_column :matches, :red_baron_kills, :integer
    add_column :matches, :red_dragon_kills, :integer
    add_column :matches, :red_vilemaw_kills, :integer
    add_column :matches, :red_rift_herald_kills, :integer
    add_column :matches, :blue_tower_kills, :integer
    add_column :matches, :blue_inhibitor_kills, :integer
    add_column :matches, :blue_baron_kills, :integer
    add_column :matches, :blue_dragon_kills, :integer
    add_column :matches, :blue_vilemaw_kills, :integer
    add_column :matches, :blue_rift_herald_kills, :integer
    add_column :matches, :match_type, :string
    add_column :matches, :queue_id, :integer

    remove_column :matches, :winner
    remove_column :matches, :kills
    remove_column :matches, :deaths
    remove_column :matches, :assists
    remove_column :matches, :champion
    remove_column :matches, :lane
    remove_column :matches, :opponent_champion
    remove_column :matches, :opponent_summoner_name
    remove_column :matches, :opponent_riot_id
    remove_column :matches, :summoner_id
    remove_column :matches, :damage_dealt_to_champions
    remove_column :matches, :damage_dealt_to_champions_per_min
    remove_column :matches, :damage_taken
    remove_column :matches, :damage_taken_per_min
    remove_column :matches, :damage_taken_per_min_zero_to_ten
    remove_column :matches, :damage_taken_per_min_ten_to_twenty
    remove_column :matches, :damage_taken_per_min_twenty_to_thirty
    remove_column :matches, :damage_taken_per_min_thirty_to_end
    remove_column :matches, :gold
    remove_column :matches, :gold_per_min
    remove_column :matches, :gold_per_min_zero_to_ten
    remove_column :matches, :gold_per_min_ten_to_twenty
    remove_column :matches, :gold_per_min_twenty_to_thirty
    remove_column :matches, :gold_per_min_thirty_to_end
    remove_column :matches, :cs
    remove_column :matches, :cs_per_min_zero_to_ten
    remove_column :matches, :cs_per_min_ten_to_twenty
    remove_column :matches, :cs_per_min_twenty_to_thirty
    remove_column :matches, :cs_per_min_thirty_to_end
    remove_column :matches, :xp_per_min_zero_to_ten
    remove_column :matches, :xp_per_min_ten_to_twenty
    remove_column :matches, :xp_per_min_twenty_to_thirty
    remove_column :matches, :xp_per_min_thirty_to_end
    remove_column :matches, :opponent_kills
    remove_column :matches, :opponent_deaths
    remove_column :matches, :opponent_assists
    remove_column :matches, :opponent_damage_dealt_to_champions
    remove_column :matches, :opponent_damage_dealt_to_champions_per_min
    remove_column :matches, :opponent_damage_taken
    remove_column :matches, :opponent_damage_taken_per_min
    remove_column :matches, :opponent_damage_taken_per_min_zero_to_ten
    remove_column :matches, :opponent_damage_taken_per_min_ten_to_twenty
    remove_column :matches, :opponent_damage_taken_per_min_twenty_to_thirty
    remove_column :matches, :opponent_damage_taken_per_min_thirty_to_end
    remove_column :matches, :opponent_gold
    remove_column :matches, :opponent_gold_per_min
    remove_column :matches, :opponent_gold_per_min_zero_to_ten
    remove_column :matches, :opponent_gold_per_min_ten_to_twenty
    remove_column :matches, :opponent_gold_per_min_twenty_to_thirty
    remove_column :matches, :opponent_gold_per_min_thirty_to_end
    remove_column :matches, :opponent_cs
    remove_column :matches, :opponent_cs_per_min_zero_to_ten
    remove_column :matches, :opponent_cs_per_min_ten_to_twenty
    remove_column :matches, :opponent_cs_per_min_twenty_to_thirty
    remove_column :matches, :opponent_cs_per_min_thirty_to_end
    remove_column :matches, :opponent_xp_per_min_zero_to_ten
    remove_column :matches, :opponent_xp_per_min_ten_to_twenty
    remove_column :matches, :opponent_xp_per_min_twenty_to_thirty
    remove_column :matches, :opponent_xp_per_min_thirty_to_end
  end
end
