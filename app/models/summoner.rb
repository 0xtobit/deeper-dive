class Summoner < ActiveRecord::Base
  has_many :matches, inverse_of: :summoner

  # TODO: after_save to use summoner_id instead of name

  validates :name, uniqueness: true
  validates :riot_id, uniqueness: true
  # TODO uniqueness

  def get_new_match_ids
    client = RiotApi.client
    summoner = client.get_summoner_by_name(name)

    existing_match_ids = matches.pluck(:match_id).to_set
    new_match_ids = Set.new
    summoner.match_list.each do |match|
      new_match_ids << match.match_id unless existing_match_ids.include?(match.match_id)
    end
    new_match_ids.to_a
  end
end
