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

  task all_matches: :environment do
    Match.find_each do |match|
      sleep(1.0)
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
