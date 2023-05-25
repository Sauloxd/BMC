class UsersController < ApplicationController
  def select_search
    @element_id = params[:element_id]
    
    @users = User.all
    @users = @users.where.not(id: exclude_params) if params[:excludes].present?
    @users = @users.by_email(params[:query]) if params[:query].present?
    @users = @users.in_match_series(params[:in_match_series]) if params[:in_match_series].present?
    
    respond_to do |format|
      format.turbo_stream
    end
  end

  def selected_user_search
    @user = User.find(params[:id])
    @element_id = params[:element_id]
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def exclude_params
    params[:excludes].split(',')
  end
end
