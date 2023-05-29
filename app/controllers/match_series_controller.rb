class MatchSeriesController < ApplicationController
  def index
    @match_series = MatchSeries
      .joins("left join match_series_participations ON match_series_participations.match_series_id = match_series.id")
      .select("match_series.*, count(match_series_participations.id)")
      .group("match_series.id")
      .order(created_at: :desc)
  end

  def show
    @match_series = MatchSeries.find(params[:id])
    @matches = @match_series.matches
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
        format.html { redirect_to match_series_path }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @match_series = MatchSeries.new
    @match_series_participations = @match_series.match_series_participations
    @players = User.where(id: @match_series_participations.select(:user_id))
  end

  def create
    @match_series = MatchSeries.new(match_series_params)
    @match_series.match_series_participations.build(user_ids_params) if user_ids_params.present?

    if @match_series.save
      respond_to do |format|
        format.html { redirect_to match_series_path }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @match_series = MatchSeries.find(params[:id])
    
    if @match_series.destroy
      redirect_to match_series_index_path, status: :see_other
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
