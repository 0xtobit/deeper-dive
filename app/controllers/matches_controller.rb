class MatchesController < ApplicationController
  before_action :set_match, only: :show

  def show
  end

  private
  
  def set_match
    @match = Match.find(params[:id])
  end
end
