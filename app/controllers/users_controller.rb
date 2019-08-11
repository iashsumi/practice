class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    
  end

  def new_confirm

  end

  def create

  end

  def edit

  end

  def edit_confirm

  end

  def update

  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path, flash: {success: '削除しました'}
  end

  def new_all;end

  def import
    User.bulk_insert(params[:file])
    redirect_to users_path
  end
end
