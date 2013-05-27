class HomeController < ApplicationController
  def index
  
  end
  
  def search
    @users = User.user_search_by_keyword(params[:search_keyword])
  end
end
