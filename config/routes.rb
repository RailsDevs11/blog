Cat::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "user_registrations"}
  
  #devise_for :users
  
  namespace 'user' do
    resources 'dashboard' , :only => [:index]
    resource 'profile', :only => [:show] do
      put :change_password
      put :change_username
    end
  end

  root :to => 'home#index'
end
