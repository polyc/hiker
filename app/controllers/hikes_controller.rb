class HikesController < ApplicationController

  before_action :authenticate_user, :only => [:new, :create, :index, :show]

  def index
    @hikes = Hike.all.order(:created_at)
  end

  def new
    @hike = Hike.new
  end

  def show
    id = params[:id]
    @hike = Hike.find(id)
    @user = User.find(session[:user_id])
    @favorite = Favorite.where(user_id: @user.id, favoritable_id: @hike.id)
  end

  def create
    @hike = Hike.new(hike_params)
    @hike.user_id = User.find(session[:user_id]).id
    if @hike.save
      flash[:notice]= "Hike created successfully"
      redirect_to hikes_path
    else
      flash[:warning]= "Invalid form compilation"
      render "new"
    end
  end

  private
  def hike_params
    params.require(:hike).permit(:name, :difficulty, :nature, :equipment, :description, :rating, :tipo, :filename, :hike_image, :user_id)
  end

end
