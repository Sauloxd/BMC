class MatchSeriesController < ApplicationController
  def index
    @match_series = MatchSeries
      .joins("left join match_series_participations ON match_series_participations.match_series_id = match_series.id")
      .select("match_series.*, count(match_series_participations.id)")
      .group("match_series.id")
      .order(created_at: :desc)
  end

  def edit
    @match_series = MatchSeries.find(params[:id]) 
  end

  def update
    @match_series = MatchSeries.find(params[:id]) 

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
  end

  def create
    @match_series = MatchSeries.new(match_series_params)
    @match_series.match_series_participations.build(params[:user_ids].map{|id| { user_id: id } })
    
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
end
