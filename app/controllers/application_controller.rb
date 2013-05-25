class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      return user_dashboard_index_path
    elsif resource.is_a?(Public)
      return public_comments_path
    end
  end

  def after_update_path_for(resource)
    if resource.is_a?(User)
      return user_dashboard_index_path
    end
  end

end
