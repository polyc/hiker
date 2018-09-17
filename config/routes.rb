Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :hikes do
    resources :comments
  end

  root :to => redirect('/users')
  get "signup", :to => "users#new"
  get "hike_preferencies_setup", :to => "users#hike_preferencies_setup"
  put "hike_preferencies_setup", :to => "users#hike_preferencies_update"

  get "login", :to => "sessions#login"
  get "logout", :to => "sessions#logout"
  get "home", :to => "sessions#home"
  get "profile", :to => "sessions#profile"
  get "setting", :to => "sessions#setting"
  post "login_attempt", :to => "sessions#login_attempt"

  #get "hikes", :to => "hikes#index"
  #get "hikes", :to => "hikes#new"
  #post "hikes", :to => "hikes#create"
  #get "hikes", :to => "hikes#show"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  #get 'comments/create,'
  #get 'comments/update,'
  #get 'comments/show,'
  #get 'comments/delete'
end
