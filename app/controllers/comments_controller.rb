class CommentsController < ApplicationController

  before_action :authenticate_user, :only => [:new, :create, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = User.find(session[:user_id]).id
    @comment.hike_id = params[:hike_id]
    if @comment.save
      flash[:notice] = "comment created"
      redirect_to hike_path(Hike.find(params[:hike_id]))
    else
      flash[:warning] = "Form invalid"
      render "new"
    end
  end

  def update
  end

  def show
  end

  def destroy
    @comment = Comment.find(params[:id])
    if User.find(@comment.user_id).id == session[:user_id]
      @comment.destroy
      flash[:notice] = "comment deleted"
    else
      flash[:warning] = "Impossibile cancellare commento altrui"
    end
    redirect_to hike_path(Hike.find(params[:hike_id]))
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
