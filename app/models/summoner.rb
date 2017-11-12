class Summoner < ActiveRecord::Base
  has_many :matches, inverse_of: :summoner

  after_save :set_riot_id, if: -> { riot_id.nil? }

  validates :name, uniqueness: true
  validates :riot_id, uniqueness: true

  def set_riot_id
    return if riot_id
    client = Riot::Client
    update_attributes(riot_id: client.account_id(name))
  end

  def get_new_match_ids
    existing_match_ids = matches.pluck(:match_id).to_set
    new_match_ids = Set.new
    Riot::Client.all_game_ids(riot_id).each do |match|
      new_match_ids << match.match_id unless existing_match_ids.include?(match.match_id)
    end
    new_match_ids.to_a
  end
end
