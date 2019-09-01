class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def new_confirm
    @user = User.new(user_params)
    render :new unless @user.valid?
  end

  def create
    @user = User.new(user_params)
    return render :new unless @user.save

    redirect_to users_path, flash: { success: '登録しました' }
  end

  def edit
    @user = User.find(params[:id])
  end

  def edit_confirm
    @user = User.find(params[:id])
    @user.attributes = user_params
    render :new unless @user.valid?
  end

  def update
    @user = User.find(params[:id])
    @user.attributes = user_params
    return render :edit unless @user.save

    redirect_to users_path, flash: { success: '更新しました' }
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path, flash: { success: '削除しました' }
  end

  def new_all; end

  def import
    User.bulk_insert(params[:file])
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(
      :id,
      :name,
      :address,
      :email,
      :avatar,
      :avatar_cache
    )
  end
end
