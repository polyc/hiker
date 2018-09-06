class UsersController < ApplicationController

  before_filter :save_login_state, :only => [:new, :create]

  def index
    @users = User.all.order(:nickname)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Signup successfull"
    ##  redirect to login page da implementare
    else
      flash[:notice] = "Form invalid"
      flash[:color]  = "invalid"
      render "new"
  end

  private
  def user_params
    params.require(:user).permit(:name, :surname, :gender, :birthdate, :nickname, :email, :city, :description)
  end
end
