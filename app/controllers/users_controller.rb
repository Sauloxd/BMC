class UsersController < ApplicationController
  def select_search
    @users = if params[:state] == "reset"
      User.none
    else
      User.all
    end
    @users = @users.where.not(id: exclude_params)
    @users = @users.by_email(params[:query]) if params[:query].present?
    respond_to do |format|
      format.turbo_stream
    end
  end

  def selected_user_search
    @user = User.find(params[:id])

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def exclude_params
    return [] unless params[:excludes].present?

    params[:excludes].split(',')
  end
end
