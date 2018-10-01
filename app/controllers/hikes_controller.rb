class HikesController < ApplicationController

  before_action :authenticate_user, :only => [:new, :create, :index, :show, :upload_hike_photo_setup, :upload_hike_photo_update]

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
      session["tmp_hikeID"] = @hike.id
      redirect_to hike_photo_upload_setup_path(@hike)
    else
      flash[:warning]= "Invalid form compilation"
      render "new"
    end
  end

  def hike_photo_upload_setup

  end

  def hike_photo_upload_update
    @hike = Hike.find(session["tmp_hikeID"])
    session["tmp_hikeID"] = nil
    if @hike.update_attribute(:hike_image, Rails.root.join(hike_params[:hike_image]).open)
      flash[:notice] = "Hike photo uploaded"
    else
      flash[:warning] = "No photo uploaded"
    end
    redirect_to hikes_path
  end

  private
  def hike_params
    params.require(:hike).permit(:name, :difficulty, :nature, :equipment, :description, :rating, :tipo, :filename, :hike_image, :user_id)
  end

end
