class User::DashboardController < User::BaseController
  before_filter :authenticate_user!
  def index

  end
end