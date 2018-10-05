class UsersController < ApplicationController

  before_action :save_login_state, :only => [:new, :create]
  before_action :authenticate_user, :only => [:show, :edit, :update, :add_following, :add_to_banned_users, :add_hike_to_favorites, :remove_from_banned_users, :followers, :following]

  def index
    @users = User.all.order(:nickname)
  end

  def show
    id = params[:id]
    @user = User.find(id)
    @user_hikes = pag(Hike.all.where(user_id:@user.id))
    @current_user = User.find(session[:user_id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.hike_pref = ["T", "E", "EE", "EEA", "EAI"].to_s
    if @user.save
      flash[:notice] = "Signed up successfully"
      redirect_to login_path
    else
      flash[:warning] = "Form invalid"
      render "new"
    end
  end

  def edit
    id = params[:id]
    @user = User.find(id)
  end

  def update
    id = params[:id]
    @user = User.find(id)
    if @user.update_attributes(edit_user_params)
      flash[:notice] = "#{@user.nickname} was successfully update"
		  redirect_to profile_path
    else
      flash[:warning] = "Form invalid"
    end

  end

  def upload_user_picture
    @user = User.find(session[:user_id])
    @user.update_attribute(:image, user_params[:image])
    redirect_to home_path
  end

  def delete_user
    @user = User.find(session[:user_id])
    @user.destroy()
    session[:user_id] = nil
    redirect_to users_path
  end
  #USER HIKE PREFERENCIES METHODS
  ##############################################################################

  def hike_preferencies_setup

  end

  def hike_preferencies_update
    @user = User.find(session[:user_id])
    @user.update_attribute(:hike_pref, params[:hike_pref].to_s)
    flash[:notice] = "Your hike's preferencies were successfully updated"
		redirect_to profile_path
  end

  #FOLLOW ACTIONS
  ##############################################################################

  def add_following
    @user = User.find(session[:user_id])
    @user.active_relationships.create(followed_id: params[:format].to_i)
    redirect_to users_path
  end

  def delete_following
    @user = User.find(session[:user_id])
    @user.following.delete(params[:format])
    redirect_to users_path
  end

  def followers
    @title = "Followers"
    id = session[:user_id]
    @user = User.find(id)
    @users = pag(@user.followers)
    render 'show_follow'
  end

  def following
    @title = "Following"
    id = session[:user_id]
    @user = User.find(id)
    @users = pag(@user.following)
    render 'show_follow'
  end

  #BAN ACTIONS
  ##############################################################################

  def add_to_banned_users
    @user = User.find(session[:user_id])
    @banned = User.find(params[:format])
    @user.active_ban_relationships.create(banned_id: params[:format].to_i)

    if @user.following?(@banned)
      @user.unfollow(@banned)
    end
    if @banned.following?(@user)
      @banned.unfollow(@user)
    end

    redirect_to user_path(@banned)
  end

  def remove_from_banned_users
    @user = User.find(session[:user_id])
    @banned = User.find(params[:format])
    @user.unban(User.find(params[:format]))
    redirect_to user_path(@banned)
  end

  #PRIVATE METHODS
  ##############################################################################
  private
  def user_params
    params.require(:user).permit(:name, :surname, :gender, :birthdate, :nickname, :email, :city, :password, :password_confirmation, :image, :hike_pref)
  end

  private
  def edit_user_params
    params.require(:user).permit(:name, :surname, :gender, :birthdate, :city, :image)
  end

  private
  def pag(obj)
    obj.paginate(:page => params[:page], :per_page => 4)
  end
end
