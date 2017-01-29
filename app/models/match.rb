class Match < ActiveRecord::Base
  belongs_to :summoner, inverse_of: :matches
  # TODO uniqueness

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
end
