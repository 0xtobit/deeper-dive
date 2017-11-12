class CreateParticipantsTable < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :match_id, index: true, foreign_key: true
      t.integer :participant_id, limit: 8
      t.integer :account_id, limit: 8
      t.string :lane
      t.string :role
      t.string :team_id
      t.boolean :winner
      t.integer :champion_id
      t.string  :champion

      t.integer :kills
      t.integer :deaths
      t.integer :assists

      t.integer :largest_killing_spree
      t.integer :largest_multi_kill
      t.integer :killing_sprees
      t.integer :double_kills
      t.integer :triple_kills
      t.integer :quadra_kills
      t.integer :penta_kills
      t.integer :unreal_kills
      t.integer :longest_time_spent_living

      t.integer :total_damage_dealt
      t.integer :magic_damage_dealt
      t.integer :physical_damage_dealt
      t.integer :magic_damage_dealt_to_champions
      t.integer :physical_damage_dealt_to_champions
      t.integer :total_heal
      t.integer :total_units_healed
      t.integer :damage_self_mitigated
      t.integer :damage_dealt_to_objectives
      t.integer :damage_dealt_to_turrets
      t.integer :vision_score
      t.integer :vision_wards_bought_in_game
      t.integer :time_ccing_others
      t.integer :turret_kills
      t.integer :inhibitor_kills
      t.integer :total_minions_killed
      t.integer :neutral_minions_killed
      t.integer :neutral_minions_killed_team_jungle
      t.integer :neutral_minions_killed_enemy_jungle
      t.integer :total_time_crowd_control_dealt
      t.boolean :first_blood_kill
      t.boolean :first_blood_assist
      t.boolean :first_tower_kill
      t.boolean :first_tower_assist
      t.boolean :first_inhibitor_kill
      t.boolean :first_inhibitor_assist

      t.integer :damage_dealt_to_champions
      t.float :damage_dealt_to_champions_per_min

      t.integer :damage_taken
      t.float :damage_taken_per_min
      t.float :damage_taken_per_min_zero_to_ten
      t.float :damage_taken_per_min_ten_to_twenty
      t.float :damage_taken_per_min_twenty_to_thirty
      t.float :damage_taken_per_min_thirty_to_end

      t.float :damage_taken_diff_per_min_zero_to_ten
      t.float :damage_taken_diff_per_min_ten_to_twenty
      t.float :damage_taken_diff_per_min_twenty_to_thirty
      t.float :damage_taken_diff_per_min_thirty_to_end

      t.integer :gold
      t.float :gold_per_min
      t.float :gold_per_min_zero_to_ten
      t.float :gold_per_min_ten_to_twenty
      t.float :gold_per_min_twenty_to_thirty
      t.float :gold_per_min_thirty_to_end

      t.integer :cs
      t.float :cs_per_min_zero_to_ten
      t.float :cs_per_min_ten_to_twenty
      t.float :cs_per_min_twenty_to_thirty
      t.float :cs_per_min_thirty_to_end

      t.float :cs_diff_per_min_zero_to_ten
      t.float :cs_diff_per_min_ten_to_twenty
      t.float :cs_diff_per_min_twenty_to_thirty
      t.float :cs_diff_per_min_thirty_to_end

      t.float :xp_per_min_zero_to_ten
      t.float :xp_per_min_ten_to_twenty
      t.float :xp_per_min_twenty_to_thirty
      t.float :xp_per_min_thirty_to_end

      t.float :xp_diff_per_min_zero_to_ten
      t.float :xp_diff_per_min_ten_to_twenty
      t.float :xp_diff_per_min_twenty_to_thirty
      t.float :xp_diff_per_min_thirty_to_end

      t.timestamps null: false
    end
  end
end
