class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  
  #override the devise method
  #it will return user dashboard
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      return user_dashboard_index_path
    end
  end
  
  #override the devise methods
  #it will return user dashboard if update user profile
  def after_update_path_for(resource)
    if resource.is_a?(User)
      return user_dashboard_index_path
    end
  end

end
