class AddOpponentChampionToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :opponent_champion, :string
  end
end
