Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    member do
     get :following, :followers
   end
  end
  resources :hikes do
    resources :comments
  end

  root :to => redirect('/users')
  get "signup", :to => "users#new"
  get "hike_preferencies_setup", :to => "users#hike_preferencies_setup"
  put "hike_preferencies_setup", :to => "users#hike_preferencies_update"

  get "hike_photo", :to => "hikes#upload_hike_photo_setup"
  put "hike_photo", :to => "hikes#upload_hike_photo_update"

  get "login", :to => "sessions#login"
  get "logout", :to => "sessions#logout"
  get "home", :to => "sessions#home"
  get "profile", :to => "sessions#profile"
  get "setting", :to => "sessions#setting"
  post "login_attempt", :to => "sessions#login_attempt"
  get "search", :to => "sessions#index"
  get "change_password", :to => "sessions#change_password"
  post "change_password", :to => "sessions#update_password"
  get "change_email", :to => "sessions#change_email"
  post "change_email", :to => "sessions#update_email"
  get "change_nickname", :to => "sessions#change_nickname"
  post "change_nickname", :to => "sessions#update_nickname"
  post "set_profile_private", :to => "sessions#set_profile_private"

  post "add_following", :to => "users#add_following"
  post "delete_following", :to => "users#delete_following"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  #get 'comments/create,'
  #get 'comments/update,'
  #get 'comments/show,'
  #get 'comments/delete'
end
