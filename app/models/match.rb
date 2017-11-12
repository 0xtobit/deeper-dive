class Match < ActiveRecord::Base

  scope :with_opponent, -> { where('opponent_champion IS NOT NULL') }

  belongs_to :summoner, inverse_of: :matches
  has_many :participants, inverse_of: :match

  validates :match_id, uniqueness: { scope: :summoner_id }

  validates :match_id, presence: true
  validates :summoner_id, presence: true
  validates :champion, presence: true
  validates :lane, presence: true
  validates :queue, presence: true
  validates :season, presence: true
  validates :match_creation, presence: true
  validates :match_duration, presence: true

  include MatchAttributes

  def kda
    (kills + assists) / [deaths, 1].max.to_f
  end

  def opponent_kda
    (opponent_kills + opponent_assists) / [opponent_deaths, 1].max.to_f
  end

  def cs_per_min
    cs / (match_duration / 60.0)
  end

  def opponent_cs_per_min
    opponent_cs / (match_duration / 60.0)
  end

  def creation_pretty
    match_creation.in_time_zone('MST').strftime('%b %e, %Y %H:%M %Z')
  end

  def duration_pretty
    t = Time.at(match_duration).utc
    t.strftime("#{t.hour > 0 ? '%kh ' : ''}%Mm")
  end
end
