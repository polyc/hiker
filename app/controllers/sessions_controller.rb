class SessionsController < ApplicationController
  before_action :authenticate_user, :only => [:home, :profile, :setting, :search]
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
  end

  def logout
    session[:user_id] = nil
    redirect_to :action => 'login'
  end

end
