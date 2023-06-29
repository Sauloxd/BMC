class ClubsController < ApplicationController
  before_action :authenticate_user!
  verify_authorized only: :update 

  def index
    @clubs = Club.has_user(current_user.id)
    @clubs = Club.all if current_user.email == 'admin@admin.com'
    @clubs = @clubs
      .joins("LEFT JOIN memberships as mbms ON mbms.club_id = clubs.id")
      .select("clubs.*, count(mbms.id)")
      .group("clubs.id")
      .order(created_at: :desc)
  end

  def show
    @club = Club.find(params[:id])
    @match_series = @club.match_series
  end

  def new
    @club = Club.new
  end

  def create
    @club = Club.new(owner: current_user, **club_params)
    @club.memberships.build(member_ids_params) if member_ids_params.present?
    
    if @club.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @club = Club.find(params[:id])
    @members = User.in_club(params[:id])
  end

  def update
    @club = Club.find(params[:id])
    authorize! @club
    current_user_ids = @club.memberships.pluck(:user_id)
    to_be_created = (params[:member_ids] || []) - current_user_ids
    to_be_deleted = current_user_ids - (params[:member_ids] || [])

    ActiveRecord::Base.transaction do
      @club.memberships.where(user_id: to_be_deleted).delete_all
      @club.memberships.build(to_be_created.map {|u| { user_id: u }})
      @club.update(club_params)
    end

    respond_to do |format|
      format.turbo_stream
    end
  rescue StandardError => e
    respond_to do |format|
      format.turbo_stream do
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @club = Club.find(params[:id])
    
    if @club.destroy
      redirect_to clubs_path, status: :see_other
    end
  end
  
  private

  def club_params
    params.require(:club).permit(:name)
  end

  def member_ids_params
    member_ids = params[:member_ids] || []
    member_ids << current_user.id.to_s
    member_ids.uniq.map{ |id| { user_id: id } }
  end
end
