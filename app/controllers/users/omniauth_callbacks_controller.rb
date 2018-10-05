class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      session[:user_id] = @user.id
      flash[:notice] = "successfully signed in with facebook"
      redirect_to profile_path
    else
      flash[:warning] = "Something went wrong with facebook"
      redirect_to login_path
    end
  end

  def failure
    redirect_to root_path
  end
end
