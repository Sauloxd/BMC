class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    redirect_to clubs_path
  end
end
