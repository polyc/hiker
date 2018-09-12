class HikesController < ApplicationController

  before_action :authenticate_user, :only => [:new, :create, :index]
  #before_action :save_login_state, :only => [:new, :create]

  def index
    @hikes = Hike.all.order(:created_at)
  end

  def new
    @hike = Hike.new
  end

  def create
    @hike = Hike.new(hike_params)
      if @hike.save
        flash[:notice]= "Hike created successfully"
        #redirect_to hike_path
      else
        flash[:warning]= "Invalid form compilation"
        render "new"
      end
  end

  private
  def hike_params
    params.require(:hike).permit(:name, :difficulty, :nature, :rating, :tipo)
  end

end
