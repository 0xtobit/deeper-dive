class AddOpponentSummonerNameAndIdToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :opponent_summoner_name, :string
    add_column :matches, :opponent_riot_id, :integer
  end
end
