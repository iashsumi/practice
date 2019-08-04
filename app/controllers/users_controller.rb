class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(20)
  end

  def new_all;end

  def import
    User.bulk_insert(params[:file])
    redirect_to users_path
  end
end
