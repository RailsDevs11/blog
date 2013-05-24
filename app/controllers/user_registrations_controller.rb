class UserRegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!, :only => [:update, :edit]
  layout 'dashboard', :only => [:edit, :update]

  def update
    # required for settings form to submit when password is left blank
    @user = current_user
    if @user.update_without_password(params[:user])
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to user_dashboard_index_path
    else
      render "edit_personal"
    end
  end

end
