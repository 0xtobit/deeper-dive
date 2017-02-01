class SummonersController < ApplicationController
  before_action :set_summoner, only: :show

  def index
    @summoners = Summoner.all
  end

  def show
    #matches = @summoner.matches.paginate(page: params[:page], per_page: 10)
    matches = Match.with_opponent.where(summoner: @summoner).order(match_creation: :desc)
    matches = matches.where(champion: params[:champion].titleize) if params.has_key? :champion
    @matches = matches.paginate(page: params[:page], per_page: 10)
  end

  private

  def set_summoner
    @summoner = Summoner.find(params[:id])
  end
end
