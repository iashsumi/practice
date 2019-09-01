class ActiveStragePracticesController < ApplicationController
  def index
    @practices = ActiveStragePractice.page(params[:page]).per(20)
  end

  def show
    @practice = ActiveStragePractice.find(params[:id])
  end

  def new
    @practice = ActiveStragePractice.new
  end

  def new_confirm
    @practice = ActiveStragePractice.new(practice_params)
    render :new unless @practice.valid?
  end

  def create
    @practice = ActiveStragePractice.new(practice_params)
    @practice.avatar.attach(ActiveStorage::Blob.find(@practice.avatar_blob_id))
    render :new unless @practice.save
    redirect_to active_strage_practices_path, flash: { success: '登録しました' }
  end

  def destroy
    ActiveStragePractice.find(params[:id]).destroy
    redirect_to active_strage_practices_path, flash: { success: '削除しました' }
  end

  private

  def practice_params
    params.require(:active_strage_practice).permit(
      :name,
      :avatar,
      :avatar_blob_id
    )
  end
end
