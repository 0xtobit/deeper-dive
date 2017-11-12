module MatchAttributes
  extend ActiveSupport::Concern

  SEASON = {
    0 => 'PRESEASON 3',
    1 => 'SEASON 3',
    2 => 'PRESEASON 2014',
    3 => 'SEASON 2014',
    4 => 'PRESEASON 2015',
    5 => 'SEASON 2015',
    6 => 'PRESEASON 2016',
    7 => 'SEASON 2016',
    8 => 'PRESEASON 2017',
    9 => 'SEASON 2017'
  }


  def sync
    r = Riot::Client.new({})
    match = r.match(match_id)
    assign_attributes(
      match_id: match['gameId'],
      queue: match['queueId'],
      region: match['platformId'],
      season: SEASON[match['seasonId']],
      match_creation: Time.at(match['gameCreation'] / 1000.0),
      match_duration: match['gameDuration'],
      match_mode: match['gameMode'],
      match_type: match['gameType'],
      queue_id: match['gameType']
    )
    blue_team = match['teams'].find { |team| team['teamId'] == 100 }
    red_team = match['teams'].find { |team| team['teamId'] == 200 }
    assign_attributes(
      first_blood: red_team['firstBlood'] ? 'red' : 'blue',
      first_tower: red_team['firstTower'] ? 'red' : (blue_team['firstTower'] ? 'blue' : nil),
      first_inhibitor: red_team['firstInhibitor'] ? 'red' : (blue_team['firstInhibitor'] ? 'blue' : nil),
      first_baron: red_team['firstBaron'] ? 'red' : (blue_team['firstBaron'] ? 'blue' : nil),
      first_dragon: red_team['firstDragon'] ? 'red' : (blue_team['firstDragon'] ? 'blue' : nil),
      first_rift_herald: red_team['firstRiftHerald'] ? 'red' : (blue_team['firstRiftHerald'] ? 'blue' : nil),
      red_tower_kills:       red_team['towerKills'],
      red_inhibitor_kills:   red_team['inhibitorKills'],
      red_baron_kills:       red_team['baronKills'],
      red_dragon_kills:      red_team['dragonKills'],
      red_vilemaw_kills:     red_team['vilemawKills'],
      red_rift_herald_kills: red_team['riftHeraldKills'],
      blue_tower_kills:       blue_team['towerKills'],
      blue_inhibitor_kills:   blue_team['inhibitorKills'],
      blue_baron_kills:       blue_team['baronKills'],
      blue_dragon_kills:      blue_team['dragonKills'],
      blue_vilemaw_kills:     blue_team['vilemawKills'],
      blue_rift_herald_kills: blue_team['riftHeraldKills'],
    )
    make_participants(match)
  end

  def make_participants(match)
    (1..10).each do |id|
      _participant = match['participants'].find { |p| p['participantId'] == id }
      _participant_id = match['participantIdentities'].find { |p| p['participantId'] == id }
      make_participant(_participant, _participant_id)
    end
  end

  def make_participant(participant, participant_id)
    duration = match_duration / 60.0
    participants.create(
      participant_id: participant['participantId'],
      account_id: participant_id['player']['accountId'],
      lane: participant['timeline']['lane'].downcase,
      role: participant['timeline']['role'].downcase,
      team_id: participant_id['teamId'] == 100 ? 'blue' : 'red',
      winner: participant['stats']['win'],
      champion_id: participant['championId'],
      champion: CHAMPION_NAME[participant['championId']],
      kills: participant['stats']['kills'],
      deaths: participant['stats']['deaths'],
      assists: participant['stats']['assists'],
      largest_killing_spree: participant['stats']['largestKillingSpree'],
      largest_multi_kill: participant['stats']['largestMultiKill'],
      killing_sprees: participant['stats']['killingSprees'],
      double_kills: participant['stats']['doubleKills'],
      triple_kills: participant['stats']['tripleKills'],
      quadra_kills: participant['stats']['quadraKills'],
      penta_kills: participant['stats']['pentaKills'],
      unreal_kills: participant['stats']['unrealKills'],
      longest_time_spent_living: participant['stats']['longestTimeSpentLiving'],
      total_damage_dealt: participant['stats']['totalDamageDealt'],
      magic_damage_dealt: participant['stats']['magicDamageDealt'],
      physical_damage_dealt: participant['stats']['physicalDamageDealt'],
      total_heal: participant['stats']['totalHeal'],
      total_units_healed: participant['stats']['totalUnitsHealed'],
      damage_self_mitigated: participant['stats']['damageSelfMitigated'],
      damage_dealt_to_objectives: participant['stats']['damageDealtToObjectives'],
      damage_dealt_to_turrets: participant['stats']['damageDealtToTurrets'],
      vision_score: participant['stats']['visionScore'],
      vision_wards_bought_in_game: participant['stats']['visionWardsBoughtInGame'],
      time_ccing_others: participant['stats']['timeCCingOthers'],
      turret_kills: participant['stats']['turretKills'],
      inhibitor_kills: participant['stats']['inhibitorKills'],
      total_minions_killed: participant['stats']['totalMinionsKilled'],
      neutral_minions_killed: participant['stats']['neutralMinionsKilled'],
      neutral_minions_killed_team_jungle: participant['stats']['neutralMinionsKilledTeamJungle'],
      neutral_minions_killed_enemy_jungle: participant['stats']['neutralMinionsKilledEnemyJungle'],
      total_time_crowd_control_dealt: participant['stats']['totalTimeCrowdControlDealt'],
      first_blood_kill: participant['stats']['firstBloodKill'],
      first_blood_assist: participant['stats']['firstBloodAssist'],
      first_tower_kill: participant['stats']['firstTowerKill'],
      first_tower_assist: participant['stats']['firstTowerAssist'],
      first_inhibitor_kill: participant['stats']['firstInhibitorKill'],
      first_inhibitor_assist: participant['stats']['firstInhibitorAssist'],

      damage_dealt_to_champions: participant['stats']['totalDamageDealtToChampions'],
      magic_damage_dealt_to_champions: participant['stats']['magicDamageDealtToChampions'],
      physical_damage_dealt_to_champions: participant['stats']['physicalDamageDealtToChampions'],
      damage_dealt_to_champions_per_min: participant['stats']['totalDamageDealtToChampions'] / duration,

      damage_taken: participant['stats']['totalDamageTaken'],
      damage_taken_per_min: participant['stats']['totalDamageTaken'] / duration,

      damage_taken_per_min_zero_to_ten:      participant['timeline']['damageTakenPerMinDeltas']['0-10'],
      damage_taken_per_min_ten_to_twenty:    participant['timeline']['damageTakenPerMinDeltas']['10-20'],
      damage_taken_per_min_twenty_to_thirty: participant['timeline']['damageTakenPerMinDeltas']['20-30'],
      damage_taken_per_min_thirty_to_end:    participant['timeline']['damageTakenPerMinDeltas']['30-end'],

      damage_taken_diff_per_min_zero_to_ten:      participant['timeline']['damageTakenDiffPerMinDeltas']['0-10'],
      damage_taken_diff_per_min_ten_to_twenty:    participant['timeline']['damageTakenDiffPerMinDeltas']['10-20'],
      damage_taken_diff_per_min_twenty_to_thirty: participant['timeline']['damageTakenDiffPerMinDeltas']['20-30'],
      damage_taken_diff_per_min_thirty_to_end:    participant['timeline']['damageTakenDiffPerMinDeltas']['30-end'],

      gold: participant['stats']['goldEarned'],
      gold_per_min: participant['stats']['goldEarned'] / duration,
      gold_per_min_zero_to_ten:      participant['timeline']['goldPerMinDeltas']['0-10'],
      gold_per_min_ten_to_twenty:    participant['timeline']['goldPerMinDeltas']['10-20'],
      gold_per_min_twenty_to_thirty: participant['timeline']['goldPerMinDeltas']['20-30'],
      gold_per_min_thirty_to_end:    participant['timeline']['goldPerMinDeltas']['30-end'],

      cs: participant['stats']['neutralMinionsKilled'] + participant['stats']['totalMinionsKilled'],
      cs_per_min_zero_to_ten:      participant['timeline']['creepsPerMinDeltas']['0-10'],
      cs_per_min_ten_to_twenty:    participant['timeline']['creepsPerMinDeltas']['10-20'],
      cs_per_min_twenty_to_thirty: participant['timeline']['creepsPerMinDeltas']['20-30'],
      cs_per_min_thirty_to_end:    participant['timeline']['creepsPerMinDeltas']['30-end'],

      cs_diff_per_min_zero_to_ten:      participant['timeline']['csDiffPerMinDeltas']['0-10'],
      cs_diff_per_min_ten_to_twenty:    participant['timeline']['csDiffPerMinDeltas']['10-20'],
      cs_diff_per_min_twenty_to_thirty: participant['timeline']['csDiffPerMinDeltas']['20-30'],
      cs_diff_per_min_thirty_to_end:    participant['timeline']['csDiffPerMinDeltas']['30-end'],

      xp_per_min_zero_to_ten:      participant['timeline']['xpPerMinDeltas']['0-10'],
      xp_per_min_ten_to_twenty:    participant['timeline']['xpPerMinDeltas']['10-20'],
      xp_per_min_twenty_to_thirty: participant['timeline']['xpPerMinDeltas']['20-30'],
      xp_per_min_thirty_to_end:    participant['timeline']['xpPerMinDeltas']['30-end'],

      xp_diff_per_min_zero_to_ten:      participant['timeline']['xpDiffPerMinDeltas']['0-10'],
      xp_diff_per_min_ten_to_twenty:    participant['timeline']['xpDiffPerMinDeltas']['10-20'],
      xp_diff_per_min_twenty_to_thirty: participant['timeline']['xpDiffPerMinDeltas']['20-30'],
      xp_diff_per_min_thirty_to_end:    participant['timeline']['xpDiffPerMinDeltas']['30-end'],
    )
  end
end
