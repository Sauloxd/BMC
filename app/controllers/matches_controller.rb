class MatchesController < ApplicationController

  def new
    @match_series = MatchSeries.find(params[:match_series_id])
    @match = @match_series.matches.build
    @users = User.where(id: @match_series.match_series_participations.pluck(:user_id))
  end

  def create
    @match_series = MatchSeries.find(params[:match]["match_series_id"])
    @match = @match_series.matches.new(match_params)
    @match.played_at = Time.current
    if @match.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @match = Match.find(params[:id])
    @match_series = @match.match_series
    @users = User.where(id: @match.match_series.match_series_participations.pluck(:user_id))
  end

  def update
    @match = Match.find(params[:id])
    
    if @match.update(match_params)
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @match = Match.find(params[:id])
    if @match.destroy
      redirect_to match_series_matches_path(@match.match_series_id, @match.id), status: :see_other
    end
  end

  def match_params
    params.require(:match).permit(
      :match_series_id, 
      :player_a_1_id, 
      :player_a_2_id, 
      :player_b_1_id, 
      :player_b_2_id,
      :score_a,
      :score_b
    )
  end
end
