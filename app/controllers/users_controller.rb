class UsersController < ApplicationController

  before_action :save_login_state, :only => [:new, :create]

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
      flash[:notice] = "Signup successfull"
      redirect_to users_path
    else
      flash[:notice] = "Form invalid"
      flash[:color]  = "invalid"
      render "new"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :surname, :gender, :birthdate, :nickname, :email, :city, :password, :password_confirmation)
  end
end
