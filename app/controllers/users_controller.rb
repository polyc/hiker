class UsersController < ApplicationController

  before_action :save_login_state, :only => [:new, :create]
  before_action :authenticate_user, :only => [:show]

  def index
    @users = User.all.order(:nickname)
  end

  def show
    id = params[:id]
    @user = User.find(id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session["tmp_id"] = @user.id
      flash[:notice] = "Signup successfull"
      redirect_to hike_preferencies_setup_path
    else
      flash[:notice] = "Form invalid"
      flash[:color]  = "invalid"
      render "new"
    end
  end

  def hike_preferencies_setup

  end

  def hike_preferencies_update
    @user = User.find(session["tmp_id"])
		@user.update_attribute(:hike_pref, params[:hike_pref])
		flash[:notice] = "#{@user.nickname} was successfully update"
		redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :surname, :gender, :birthdate, :nickname, :email, :city, :password, :password_confirmation, :hike_pref)
  end
end
