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
  end

  def create
    @hike = Hike.new(hike_params)
    @hike.user_id = User.find(session[:user_id]).id
    if @hike.save
      flash[:notice]= "Hike created successfully"
      session["tmp_hikeID"] = @hike.id
      redirect_to hikes_path
    else
      flash[:warning]= "Invalid form compilation"
      render "new"
    end
  end

  def upload_hike_photo_setup
    #@hike = Hike.find(id: session["tmp_hikeID"])
  end

  def upload_hike_photo_update
    @hike = Hike.find(id: session["tmp_hikeID"])
    session["tmp_hikeID"] = nil
    @hike.hike_image = params[:hike_image]
    if @hike.save
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
