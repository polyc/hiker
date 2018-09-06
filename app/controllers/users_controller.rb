class UsersController < ApplicationController
  def index
    @users = User.all.order(:nickname)
  end
end
