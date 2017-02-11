namespace :riot_sync do
  desc 'Get all the games from Riot API'
  task new_matches: :environment do
    Summoner.all.each do |summoner|
      sleep(1.0)
      summoner.get_new_match_ids.each do |match_id|
        sleep(1.0)
        match = Match.new(match_id: match_id, summoner: summoner)
        i = 0
        while !match.set_match && i <=10
          puts "Retry #{i} of 10 for #{summoner.name} with match_id: #{match_id}"
          sleep(i)
          i += 1
        end

        match.sync
        puts "Match: #{match_id} for #{summoner.name} failed to save: #{match.errors}" unless match.save
      end
    end
  end

  task all_matches: :environment do
    Match.find_each do |match|
      sleep(1.0)
      i = 0
      while !match.set_match && i <=10
        puts "Retry #{i} of 10 for #{match.summoner.name} with match_id: #{match.match_id}"
        sleep(i)
        i += 1
      end

      match.sync
      puts "Match: #{match_id} for #{summoner.name} failed to save: #{match.errors}" unless match.save
    end
  end

  task bad_opponent_matches: :environment do
    puts "#{Match.where('opponent_champion IS NULL').count} no opp out of #{Match.count}"
    Match.where('opponent_champion IS NULL').find_each do |match|
      puts "trying #{match.match_id}"
      sleep(1.0)
      i = 0
      while !match.set_match && i <=10
        puts "Retry #{i} of 10 for #{match.summoner.name} with match_id: #{match.match_id}"
        sleep(i)
        i += 1
      end

      match.sync
      puts "Match: #{match_id} for #{summoner.name} failed to save: #{match.errors}" unless match.save
    end
  end

  task bad_cs_matches: :environment do
    puts "#{Match.where('cs IS NULL').count} no cs out of #{Match.count}"
    Match.where('cs IS NULL').find_each do |match|
      puts "trying #{match.match_id}"
      sleep(1.0)
      i = 0
      while !match.set_match && i <=10
        puts "Retry #{i} of 10 for #{match.summoner.name} with match_id: #{match.match_id}"
        sleep(i)
        i += 1
      end

      match.sync
      puts "Match: #{match_id} for #{summoner.name} failed to save: #{match.errors}" unless match.save
    end
  end
end
