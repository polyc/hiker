class SessionsController < ApplicationController

  before_action :authenticate_user, :only => [:home, :profile, :setting, :index, :change_email, :update_email, :change_password, :update_password,
  :change_nickname, :update_nickname, :logout, :set_profile_private, :show_favorites,
  :add_hike_to_favorites, :remove_hike_from_favorites]

  before_action :save_login_state, :only => [:login, :login_attempt]

  def login
  end

  def login_attempt
    authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      redirect_to home_path
    else
      flash[:warning] = "Invalid Username or Password"
      render "login"
    end
  end

##############################################################

  def index
    @user = User.find(session[:user_id])
    params[:condemners] = @user.condemners.ids

    ########CASO PRESENZA FILTRI
    if params[:filters] != nil

      #######FILTRO HIKE
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

      #########FILTRO UTENTE E/O CITTA'
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

    ##############CASO NESSUN FILTRO
    else
      if params[:args] != ""
        if (params[:condemners].nil? || params[:condemners].empty?)
          @hikes = pag(Hike.where(name: params[:args]))
        else
          @hikes = pag(Hike.where.not("user_id = ?", params[:condemners]).where(name: params[:args]))
        end
        @users = pag(User.where(nickname: params[:args]))
      else
        if (params[:condemners].nil? || params[:condemners].empty?)
          @hikes = pag(Hike.all)
        else
          @hikes = pag(Hike.where.not("user_id = ?", params[:condemners]))
        end
        @users = pag(User.all)
      end
    end
  end

##############################################################

  def home
    id = session[:user_id]
    @user = User.find(id)
    @hikePrefArray = @user.hike_pref.gsub('["','').gsub('"]','').gsub(' ', '').gsub('"','').split(',')
    @hikes = pag(Hike.all.where(user_id: @user.following.select("followed_id"), :tipo => @hikePrefArray).order(:created_at).reverse_order)
  end
##############################################################
  def profile
    id = session[:user_id]
    @user = User.find(id)
    @user_hikes = pag(Hike.all.where(user_id:@user.id))
    @birthdate = format_birthdate(@user)
  end

  def add_hike_to_favorites
    @user = User.find(session[:user_id])
    if @user.active_favorite_relationships.create(favoritable_id: params[:format].to_i)
      flash[:notice] = "Successfully added to my favorite hikes"
    else
      flash[:warning] = "cannot add to my favorites hikes"
    end
    redirect_to hike_path(params[:format])
  end

  def remove_hike_from_favorites
    @user = User.find(session[:user_id])

    if @user.favorites.delete(Hike.find(params[:format]))
      flash[:notice] = "Successfully removed from favorites"
    else
      flash[:warning] = "cannot remove it from favorites"
    end
    redirect_to hike_path(params[:format])
  end

  def show_favorites
      @user = User.find(session[:user_id])
      favoritable_ids = @user.favorites.select("favoritable_id")
      @favorites = pag(Hike.where(id: favoritable_ids))
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
    obj.paginate(:page => params[:page], :per_page => 4)
  end

  private
  def format_birthdate(user)
    b = user.birthdate.to_s.split
    result = b[0]
  end
end
