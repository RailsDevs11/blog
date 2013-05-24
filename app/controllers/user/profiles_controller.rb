class User::ProfilesController < User::BaseController
  before_filter :authenticate_user!

  def show
    @user = User.find(current_user)
  end

  def change_password
    @resource = current_user
    is_update = @resource.update_with_password(
      :password => params[:user][:password],
      :password_confirmation => params[:user][:password_confirmation], 
      :current_password => params[:user][:current_password]
    )
    if is_update
      flash[:notice] = "Password updated successfully"
      sign_in @resource, :bypass => true
      redirect_to user_dashboard_index_path
    end
  end

  def change_username
    @resource = current_user
    is_update = @resource.update_without_password(:username => params[:user][:username])
    if @resource.update_without_password(:username => params[:user][:username])
      flash[:notice] = "Username updated successfully"
      sign_in @resource, :bypass => true
      redirect_to user_dashboard_index_path
    end
  end
end
