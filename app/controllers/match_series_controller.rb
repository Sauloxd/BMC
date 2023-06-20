class MatchSeriesController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @match_series = MatchSeries.find(params[:id])
    @matches = @match_series.matches.order(created_at: :desc)
  end

  def edit
    @match_series = MatchSeries.find(params[:id]) 
    @match_series_participations = @match_series.match_series_participations.includes(:user)
    @players = User.where(id: @match_series_participations.select(:user_id))
  end

  def update
    @match_series = MatchSeries.find(params[:id])
    current_user_ids = @match_series.match_series_participations.pluck(:user_id)
    to_be_created = (params[:player_ids] || []) - current_user_ids
    to_be_deleted = current_user_ids - (params[:player_ids] || [])
    @match_series.match_series_participations.where(user_id: to_be_deleted).delete_all
    @match_series.match_series_participations.build(to_be_created.map {|u| { user_id: u }})
    
    if @match_series.update(match_series_params)
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @club = Club.find(params[:club_id])
    @match_series = @club.match_series.new
    @match_series_participations = @match_series.match_series_participations
    @players = User.where(id: @match_series_participations.select(:user_id))
  end

  def create
    @club = Club.find(params[:club_id])
    @match_series = @club.match_series.build(match_series_params)
    @match_series.match_series_participations.build(user_ids_params) if user_ids_params.present?

    if @match_series.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @match_series = MatchSeries.find(params[:id])
    
    if @match_series.destroy
      redirect_to club_path(@match_series.club_id), status: :see_other
    end
  end

  private

  def match_series_params
    params.require(:match_series).permit(:name)
  end

  def user_ids_params
    return if params[:player_ids].nil?
    
    params[:player_ids].map{|id| { user_id: id } }
  end
end
