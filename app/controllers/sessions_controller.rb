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
      flash[:warning] = "Invalid Username or Password"
      render "login"
    end
  end

##############################################################

  def index
    if params[:args] != ""
      @users = User.where(nickname: params[:args])
      @hikes = Hike.where(name: params[:args])
    else
      @users = User.all
      @hikes = Hike.all
    end
  end

##############################################################

  def home
    id = session[:user_id]
    @user = User.find(id)
    @hikes = Hike.all.where(user_id: @user.following.select("followed_id")).order(:created_at).reverse_order
  end
##############################################################
  def profile
    id = session[:user_id]
    @user = User.find(id)
    @user_hikes = Hike.all.where(user_id:@user.id)
  end

##############################################################
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

  def change_nickname

  end

  def update_nickname
    id = session[:user_id]
    @user = User.find(id)
    @user.update_attribute(:nickname, params[:nickname])
    flash[:notice] = "Nickname was successfully changed"
    redirect_to setting_path
  end

  def set_profile_private
    id = session[:user_id]
    @user = User.find(id)
    @user.update_attribute(:private_profile, params[:private_profile])
    flash[:notice] = "Setting updated"
    redirect_to setting_path
  end

##############################################################
  def logout
    session[:user_id] = nil
    redirect_to :action => 'login'
  end

end
