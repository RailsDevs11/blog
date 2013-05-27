class Public::ProfilesController < Public::BaseController

  #it will fetch the data of current user and will show on the profile page.
  def show
    @user = User.where(:id => params[:id]).first
  end

end
