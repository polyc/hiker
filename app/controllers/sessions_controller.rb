class SessionsController < ApplicationController
  ######DA CONTROLLARE LE AZIONI POSSIBILI QUANDO NON SI E AUTENTICATI
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
    @user = User.find(session[:user_id])
    params[:condemners] = @user.condemners.ids

    if params[:filters] != nil

      if params[:filters].include?('H')
        if params[:args] != ""
          if (params[:condemners].nil? || params[:condemners].empty?)
            @hikes = pag(Hike.where(name: params[:args]))
          else
            @hikes = pag(Hike.where.not("user_id = ?", params[:condemners]).where(name: params[:args]))
          end
        elsif (params[:condemners].nil? || params[:condemners].empty?)
          @hikes = pag(Hike.all)
        else
          @hikes = pag(Hike.where.not("user_id = ?", params[:condemners]))
        end


      elsif params[:filters].include?('U')
        if params[:filters].include?('C')
          if params[:args] != ""
            @users = pag(User.where(nickname: params[:args], city: params[:city]))
          else
            @users = pag(User.where(city: params[:city]))
          end
        elsif params[:args] != ""
          @users = pag(User.where(nickname: params[:args]))
        else
          @users = pag(User.all)
        end
      end


    else
      if (params[:condemners].nil? || params[:condemners].empty?)
        @hikes = pag(Hike.all)
      else
        @hikes = pag(Hike.where.not("user_id = ?", params[:condemners]))
      end
      @users = pag(User.all)
    end
  end

##############################################################

  def home
    id = session[:user_id]
    @user = User.find(id)
    @hikes = pag(Hike.all.where(user_id: @user.following.select("followed_id")).order(:created_at).reverse_order)
  end
##############################################################
  def profile
    id = session[:user_id]
    @user = User.find(id)
    @user_hikes = pag(Hike.all.where(user_id:@user.id))
  end

  def add_hike_to_favorites
    @user = User.find(session[:user_id])
    @hike = Hike.find(params[:format])
    association = @user.favorites.new(favoritable: @hike)
    if association.save
      flash[:notice] = "Successfully added to my favorite hikes"
    else
      flash[:warning] = "cannot add to my favorite hikes"
    end
    redirect_to hike_path(@hike)
  end

  def remove_hike_from_favorites
    @user = User.find(session[:user_id])
    @to_delete = Favorite.where(user_id: @user.id, favoritable_id: params[:format])

    if Favorite.destroy(@to_delete.ids)
      flash[:notice] = "Successfully removed from favorites"
    else
      flash[:warning] = "cannot remove it from favorites"
    end
    redirect_to hike_path(params[:format])
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
    if @user.match_password(params[:current_password]) && params[:new_password] == params[:password_confirmation]
      @user.password = params[:new_password]
      @user.save
      flash[:notice] = "Password was successfully changed"
      redirect_to setting_path
    else
      flash[:warning] = "current password wrong or new password differs from confirmation password"
      redirect_to change_password_path
    end
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

  private
  def pag(obj)
    obj.paginate(:page => params[:page], :per_page => 5)
  end

end
