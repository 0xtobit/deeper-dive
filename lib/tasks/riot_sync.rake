namespace :riot_sync do
  desc 'Get all the games from Riot API'
  task new_matches: :environment do
    Summoner.all.each do |summoner|
      sleep(1.0)
      summoner.get_new_match_ids.each do |match_id|
        sleep(1.0)
        match = Match.new(match_id: match_id, summoner: summoner)
        m = match.set_match
        i = 0
        while i <= 10 && m.nil?
          puts "Retry #{i} of 10 for #{summoner.name} with match_id: #{match_id}"
          sleep(i)
          i += 1
          m = match.set_match
        end

        match.sync
        puts "Match: #{match_id} for #{summoner.name} failed to save: #{match.errors}" unless match.save
      end
    end
  end

  task fix_matches: :environment do
    client = RiotApi.client

    # Match.where('opponent_champion is NULL').each do |m|
    Match.all.each do |m|
      sleep(1.0)
      match = client.match(m.match_id)
      i = 0
      while i <= 10 && match.nil?
        puts "Retry #{i} of 10 for #{m.summoner.name} with match_id: #{m.match_id}"
        sleep(i)
        i += 1
        match = client.match(m.match_id)
      end
      participant_id = match.participant_identities.find { |p| p.player.summoner_id == m.summoner.riot_id }.participant_id
      participant = match.participants.find { |p| p.participant_id == participant_id }

      opponent = match.participants.find { |p| p.team_id != participant && p.timeline.lane == participant.timeline.lane }
      opponent_identity = match.participant_identities.find { |p| p.participant_id == opponent.participant_id }
      m.update_attributes(
        opponent_summoner_name: opponent_identity.player.summoner_name,
        opponent_riot_id: opponent_identity.player.summoner_id,
        opponent_champion: CHAMPION_NAME[opponent.champion_id],
      )
    end
  end
end
