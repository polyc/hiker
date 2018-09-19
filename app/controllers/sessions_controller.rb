class SessionsController < ApplicationController
  before_action :authenticate_user, :only => [:home, :profile, :setting, :search, :change_email, :update_email, :change_password, :update_password]
  before_action :save_login_state, :only => [:login, :login_attempt]

  def login
  end

  def login_attempt
    authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      redirect_to users_path
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"
    end
  end

  def index
    if params[:args] != ""
      @users = User.where(nickname: params[:args])
      @hikes = Hike.where(name: params[:args])
    else
      @users = User.all
      @hikes = Hike.all
    end
  end

  def home
  end

  def profile
    id = session[:user_id]
    @user = User.find(id)
  end

  def setting
    id = session[:user_id]
    @user = User.find(id)
  end

  def change_password

  end

  def update_password
    id = session[:user_id]
    @user = User.find(id)
    @user.password = params[:password]
    @user.save
    flash[:notice] = "Password was successfully changed"
    redirect_to setting_path
  end

  def change_email

  end

  def update_email
    id = session[:user_id]
    @user = User.find(id)
    @user.update_attribute(:email, params[:email])
    flash[:notice] = "Email was successfully changed"
    redirect_to setting_path
  end

  def logout
    session[:user_id] = nil
    redirect_to :action => 'login'
  end

end
