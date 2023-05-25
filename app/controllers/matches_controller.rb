class MatchesController < ApplicationController

  def new
    @match_series = MatchSeries.find(params[:match_series_id])
    @match = @match_series.matches.build
    @users = User.where(id: @match_series.match_series_participations.pluck(:user_id))
  end

  def create
  end
end
