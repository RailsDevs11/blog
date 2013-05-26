class User::DashboardController < User::BaseController
  before_filter :authenticate_user!
  
  def index
    @recent_posts = current_user.recent_posts
    @recent_comments = current_user.recent_comments
  end
  
end
