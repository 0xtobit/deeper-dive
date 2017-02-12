class SummonersController < ApplicationController
  before_action :set_summoner, only: :show

  def index
    @summoners = Summoner.all
  end

  def show
    #matches = @summoner.matches.paginate(page: params[:page], per_page: 10)
    matches_with_opponent = Match.with_opponent.where(summoner: @summoner).order(match_creation: :desc)
    matches = Match.where(summoner: @summoner).order(match_creation: :desc)
    @matches = filter_by_params(matches_with_opponent).paginate(page: params[:page], per_page: 10)
    matches = filter_by_params(matches).paginate(page: params[:page], per_page: 10)
    @wins = matches.where(winner: true).count
    @losses = matches.where(winner: false).count
  end

  private

  def set_summoner
    @summoner = Summoner.find(params[:id])
  end

  def filter_by_params(matches)
    matches = matches.where(champion: params[:champion].titleize) if params.has_key? :champion
    matches = matches.where(opponent_champion: params[:opponent].titleize) if params.has_key? :opponent
    matches = matches.where(lane: params[:lane].upcase) if params.has_key? :lane
    queue_params = {
      'flex' => "RANKED_FLEX_SR",
      'solo' => "TEAM_BUILDER_RANKED_SOLO",
      'fives' =>"TEAM_BUILDER_DRAFT_RANKED_5x5"
    }
    matches = matches.where(queue: queue_params[params[:queue]]) if params.has_key? :queue
    matches = matches.where(season: queue_params[params[:season]]) if params.has_key? :season
    matches
  end
end
