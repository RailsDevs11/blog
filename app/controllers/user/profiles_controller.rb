class User::ProfilesController < User::BaseController
  before_filter :authenticate_user!

  #it will fetch the data of current user and will show on the profile page.
  def show
    @user = User.find(current_user)
  end

end
