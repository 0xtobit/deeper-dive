namespace :get_games do
  desc 'Get all the games from Riot API'
  task matches: :environment do
    client = RiotLolApi::Client.new do |config|
      config.region = 'na'
      config.api_key = ENV['RIOT_API_KEY']
    end

    Summoner.all.each do |summoner|
      summoner.get_new_match_ids.each do |match_id|
        match = client.match(match_id)
        i = 0
        while i <= 10 && match.nil?
          puts "retry #{i} of 10"
          sleep(i)
          i += 1
          match = client.match(match_id)
        end
        participant_id = match.participant_identities.find { |p| p.player.summoner_name == summoner.name }.participant_id
        participant = match.participants.find { |p| p.participant_id == participant_id }
        opponent = match.participants.find { |p| p.team_id != participant && p.timeline.lane == participant.timeline.lane }

        duration = match.match_duration/60.0

        Match.create!(
          summoner: Summoner.find_by(name: summoner.name),
          champion: CHAMPION_NAME[participant.champion_id],
          lane: participant.timeline.lane,
          match_id: match_id,
          queue: match.queue_type,
          region: match.region,
          season: match.season,
          match_creation: Time.at(match.match_creation),
          match_duration: match.match_duration,
          match_mode: match.match_mode,

          # statistics
          winner: participant.stats.winner,
          kills: participant.stats.kills,
          deaths: participant.stats.deaths,
          assists: participant.stats.assists,
          damage_dealt_to_champions: participant.stats.total_damage_dealt_to_champions,
          damage_dealt_to_champions_per_min: participant.stats.total_damage_dealt_to_champions / duration,

          cs: participant.stats.minions_killed + participant.stats.neutral_minions_killed,
          cs_per_min_zero_to_ten:      participant.timeline.creeps_per_min_deltas.try(:zero_to_ten),
          cs_per_min_ten_to_twenty:    participant.timeline.creeps_per_min_deltas.try(:ten_to_twenty),
          cs_per_min_twenty_to_thirty: participant.timeline.creeps_per_min_deltas.try(:twenty_to_thirty),
          cs_per_min_thirty_to_end:    participant.timeline.creeps_per_min_deltas.try(:thirty_to_end),

          damage_taken: participant.stats.total_damage_taken,
          damage_taken_per_min: participant.stats.total_damage_taken / duration,
          damage_taken_per_min_zero_to_ten:      participant.timeline.damage_taken_per_min_deltas.try(:zero_to_ten),
          damage_taken_per_min_ten_to_twenty:    participant.timeline.damage_taken_per_min_deltas.try(:ten_to_twenty),
          damage_taken_per_min_twenty_to_thirty: participant.timeline.damage_taken_per_min_deltas.try(:twenty_to_thirty),
          damage_taken_per_min_thirty_to_end:    participant.timeline.damage_taken_per_min_deltas.try(:thirty_to_end),

          gold: participant.stats.gold_earned,
          gold_per_min: participant.stats.gold_earned / duration,
          gold_per_min_zero_to_ten:      participant.timeline.gold_per_min_deltas.try(:zero_to_ten),
          gold_per_min_ten_to_twenty:    participant.timeline.gold_per_min_deltas.try(:ten_to_twenty),
          gold_per_min_twenty_to_thirty: participant.timeline.gold_per_min_deltas.try(:twenty_to_thirty),
          gold_per_min_thirty_to_end:    participant.timeline.gold_per_min_deltas.try(:thirty_to_end),

          xp_per_min_zero_to_ten:      participant.timeline.xp_per_min_deltas.try(:zero_to_ten),
          xp_per_min_ten_to_twenty:    participant.timeline.xp_per_min_deltas.try(:ten_to_twenty),
          xp_per_min_twenty_to_thirty: participant.timeline.xp_per_min_deltas.try(:twenty_to_thirty),
          xp_per_min_thirty_to_end:    participant.timeline.xp_per_min_deltas.try(:thirty_to_end),

          # statistics
          opponent_kills: opponent.stats.kills,
          opponent_deaths: opponent.stats.deaths,
          opponent_assists: opponent.stats.assists,
          opponent_damage_dealt_to_champions: opponent.stats.total_damage_dealt_to_champions,
          opponent_damage_dealt_to_champions_per_min: opponent.stats.total_damage_dealt_to_champions / duration,

          opponent_cs: opponent.stats.minions_killed + opponent.stats.neutral_minions_killed,
          opponent_cs_per_min_zero_to_ten:      opponent.timeline.creeps_per_min_deltas.try(:zero_to_ten),
          opponent_cs_per_min_ten_to_twenty:    opponent.timeline.creeps_per_min_deltas.try(:ten_to_twtnty),
          opponent_cs_per_min_twenty_to_thirty: opponent.timeline.creeps_per_min_deltas.try(:twenty_to_thirty),
          opponent_cs_per_min_thirty_to_end:    opponent.timeline.creeps_per_min_deltas.try(:thirty_to_end),

          opponent_damage_taken: opponent.stats.total_damage_taken,
          opponent_damage_taken_per_min: opponent.stats.total_damage_taken / duration,
          opponent_damage_taken_per_min_zero_to_ten:      opponent.timeline.damage_taken_per_min_deltas.try(:zero_to_ten),
          opponent_damage_taken_per_min_ten_to_twenty:    opponent.timeline.damage_taken_per_min_deltas.try(:ten_to_twtnty),
          opponent_damage_taken_per_min_twenty_to_thirty: opponent.timeline.damage_taken_per_min_deltas.try(:twenty_to_thirty),
          opponent_damage_taken_per_min_thirty_to_end:    opponent.timeline.damage_taken_per_min_deltas.try(:thirty_to_end),

          opponent_gold: opponent.stats.gold_earned,
          opponent_gold_per_min: opponent.stats.gold_earned / duration,
          opponent_gold_per_min_zero_to_ten:      opponent.timeline.gold_per_min_deltas.try(:zero_to_ten),
          opponent_gold_per_min_ten_to_twenty:    opponent.timeline.gold_per_min_deltas.try(:ten_to_twtnty),
          opponent_gold_per_min_twenty_to_thirty: opponent.timeline.gold_per_min_deltas.try(:twenty_to_thirty),
          opponent_gold_per_min_thirty_to_end:    opponent.timeline.gold_per_min_deltas.try(:thirty_to_end),

          opponent_xp_per_min_zero_to_ten:      opponent.timeline.xp_per_min_deltas.try(:zero_to_ten),
          opponent_xp_per_min_ten_to_twenty:    opponent.timeline.xp_per_min_deltas.try(:ten_to_twtnty),
          opponent_xp_per_min_twenty_to_thirty: opponent.timeline.xp_per_min_deltas.try(:twenty_to_thirty),
          opponent_xp_per_min_thirty_to_end:    opponent.timeline.xp_per_min_deltas.try(:thirty_to_end),
        )
      end
    end
  end
end
