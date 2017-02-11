module MatchAttributes
  extend ActiveSupport::Concern

  def sync
    set_match
    assign_attributes({
      summoner_id: Summoner.find_by(name: summoner.name).id,
      champion: CHAMPION_NAME[@participant.champion_id],
      lane: @participant.timeline.lane,
      match_id: match_id,
      queue: @match.queue_type,
      region: @match.region,
      season: @match.season,
      match_creation: Time.at(@match.match_creation / 1000.0),
      match_duration: @match.match_duration,
      match_mode: @match.match_mode,

      # statistics
      winner: @participant.stats.winner,
      kills: @participant.stats.kills,
      deaths: @participant.stats.deaths,
      assists: @participant.stats.assists,
      damage_dealt_to_champions: @participant.stats.total_damage_dealt_to_champions,
      damage_dealt_to_champions_per_min: @participant.stats.total_damage_dealt_to_champions / @duration,

      damage_taken: @participant.stats.total_damage_taken,
      damage_taken_per_min: @participant.stats.total_damage_taken / @duration,
      gold: @participant.stats.gold_earned,
      gold_per_min: @participant.stats.gold_earned / @duration,
      cs: @participant.stats.minions_killed + @participant.stats.neutral_minions_killed,
     })

    if @participant.timeline.try(:damage_taken_per_min_deltas).present?
      assign_attributes({
        damage_taken_per_min_zero_to_ten:      @participant.timeline.damage_taken_per_min_deltas.try(:zero_to_ten),
        damage_taken_per_min_ten_to_twenty:    @participant.timeline.damage_taken_per_min_deltas.try(:ten_to_twenty),
        damage_taken_per_min_twenty_to_thirty: @participant.timeline.damage_taken_per_min_deltas.try(:twenty_to_thirty),
        damage_taken_per_min_thirty_to_end:    @participant.timeline.damage_taken_per_min_deltas.try(:thirty_to_end),

        gold_per_min_zero_to_ten:      @participant.timeline.gold_per_min_deltas.try(:zero_to_ten),
        gold_per_min_ten_to_twenty:    @participant.timeline.gold_per_min_deltas.try(:ten_to_twenty),
        gold_per_min_twenty_to_thirty: @participant.timeline.gold_per_min_deltas.try(:twenty_to_thirty),
        gold_per_min_thirty_to_end:    @participant.timeline.gold_per_min_deltas.try(:thirty_to_end),

        cs_per_min_zero_to_ten:      @participant.timeline.creeps_per_min_deltas.try(:zero_to_ten),
        cs_per_min_ten_to_twenty:    @participant.timeline.creeps_per_min_deltas.try(:ten_to_twenty),
        cs_per_min_twenty_to_thirty: @participant.timeline.creeps_per_min_deltas.try(:twenty_to_thirty),
        cs_per_min_thirty_to_end:    @participant.timeline.creeps_per_min_deltas.try(:thirty_to_end),

        xp_per_min_zero_to_ten:      @participant.timeline.xp_per_min_deltas.try(:zero_to_ten),
        xp_per_min_ten_to_twenty:    @participant.timeline.xp_per_min_deltas.try(:ten_to_twenty),
        xp_per_min_twenty_to_thirty: @participant.timeline.xp_per_min_deltas.try(:twenty_to_thirty),
        xp_per_min_thirty_to_end:    @participant.timeline.xp_per_min_deltas.try(:thirty_to_end)
      })
    end
    if @opponent && @opponent_identity
      assign_attributes({
        # opponent statistics
        opponent_summoner_name: @opponent_identity.player.summoner_name,
        opponent_riot_id: @opponent_identity.player.summoner_id,
        opponent_champion: CHAMPION_NAME[@opponent.champion_id],
        opponent_kills: @opponent.stats.kills,
        opponent_deaths: @opponent.stats.deaths,
        opponent_assists: @opponent.stats.assists,
        opponent_damage_dealt_to_champions: @opponent.stats.total_damage_dealt_to_champions,
        opponent_damage_dealt_to_champions_per_min: @opponent.stats.total_damage_dealt_to_champions / @duration,

        opponent_cs: @opponent.stats.minions_killed + @opponent.stats.neutral_minions_killed,
        opponent_damage_taken: @opponent.stats.total_damage_taken,
        opponent_damage_taken_per_min: @opponent.stats.total_damage_taken / @duration,
        opponent_gold: @opponent.stats.gold_earned,
        opponent_gold_per_min: @opponent.stats.gold_earned / @duration
      })

      if @opponent.timeline.try(:damage_taken_per_min_deltas).present?
        assign_attributes({
          opponent_cs_per_min_zero_to_ten:      @opponent.timeline.creeps_per_min_deltas.try(:zero_to_ten),
          opponent_cs_per_min_ten_to_twenty:    @opponent.timeline.creeps_per_min_deltas.try(:ten_to_twenty),
          opponent_cs_per_min_twenty_to_thirty: @opponent.timeline.creeps_per_min_deltas.try(:twenty_to_thirty),
          opponent_cs_per_min_thirty_to_end:    @opponent.timeline.creeps_per_min_deltas.try(:thirty_to_end),

          opponent_damage_taken_per_min_zero_to_ten:      @opponent.timeline.damage_taken_per_min_deltas.try(:zero_to_ten),
          opponent_damage_taken_per_min_ten_to_twenty:    @opponent.timeline.damage_taken_per_min_deltas.try(:ten_to_twenty),
          opponent_damage_taken_per_min_twenty_to_thirty: @opponent.timeline.damage_taken_per_min_deltas.try(:twenty_to_thirty),
          opponent_damage_taken_per_min_thirty_to_end:    @opponent.timeline.damage_taken_per_min_deltas.try(:thirty_to_end),

          opponent_gold_per_min_zero_to_ten:      @opponent.timeline.gold_per_min_deltas.try(:zero_to_ten),
          opponent_gold_per_min_ten_to_twenty:    @opponent.timeline.gold_per_min_deltas.try(:ten_to_twenty),
          opponent_gold_per_min_twenty_to_thirty: @opponent.timeline.gold_per_min_deltas.try(:twenty_to_thirty),
          opponent_gold_per_min_thirty_to_end:    @opponent.timeline.gold_per_min_deltas.try(:thirty_to_end),

          opponent_xp_per_min_zero_to_ten:      @opponent.timeline.xp_per_min_deltas.try(:zero_to_ten),
          opponent_xp_per_min_ten_to_twenty:    @opponent.timeline.xp_per_min_deltas.try(:ten_to_twenty),
          opponent_xp_per_min_twenty_to_thirty: @opponent.timeline.xp_per_min_deltas.try(:twenty_to_thirty),
          opponent_xp_per_min_thirty_to_end:    @opponent.timeline.xp_per_min_deltas.try(:thirty_to_end),
        })
      else
        assign_attributes({
          opponent_cs_per_min_zero_to_ten:                nil,
          opponent_cs_per_min_ten_to_twenty:              nil,
          opponent_cs_per_min_twenty_to_thirty:           nil,
          opponent_cs_per_min_thirty_to_end:              nil,
          opponent_damage_taken_per_min_zero_to_ten:      nil,
          opponent_damage_taken_per_min_ten_to_twenty:    nil,
          opponent_damage_taken_per_min_twenty_to_thirty: nil,
          opponent_damage_taken_per_min_thirty_to_end:    nil,
          opponent_gold_per_min_zero_to_ten:              nil,
          opponent_gold_per_min_ten_to_twenty:            nil,
          opponent_gold_per_min_twenty_to_thirty:         nil,
          opponent_gold_per_min_thirty_to_end:            nil,
          opponent_xp_per_min_zero_to_ten:                nil,
          opponent_xp_per_min_ten_to_twenty:              nil,
          opponent_xp_per_min_twenty_to_thirty:           nil,
          opponent_xp_per_min_thirty_to_end:              nil
        })
      end
    else
      assign_attributes({
        opponent_summoner_name: nil,
        opponent_riot_id: nil,
        opponent_champion: nil,
        opponent_kills: nil,
        opponent_deaths: nil,
        opponent_assists: nil,
        opponent_damage_dealt_to_champions: nil,
        opponent_damage_dealt_to_champions_per_min: nil,
        opponent_cs: nil,
        opponent_damage_taken: nil,
        opponent_damage_taken_per_min: nil,
        opponent_gold: nil,
        opponent_gold_per_min: nil,
      })
    end
  end
  def set_match
    client = RiotApi.client
    @match = client.match(match_id)

    return false unless @match

    @participant_id = @match.participant_identities.find { |p| p.player.summoner_id == summoner.riot_id }.participant_id
    @participant = @match.participants.find { |p| p.participant_id == @participant_id }

    @opponent = @match.participants.find { |p| p.team_id != @participant.team_id && p.timeline.lane == @participant.timeline.lane }

    if @opponent
      @opponent_identity = @match.participant_identities.find { |p| p.participant_id == @opponent.participant_id }
    end

    @duration = @match.match_duration/60.0

    true
  end

end
