class LendingDataController < ApplicationController
  def index
    @data = LendingDatum.page(params[:page]).per(20)
  end

  def show
    @datum = LendingDatum.find(params[:id])
  end

  def new
    @datum = LendingDatum.new
  end

  def new_confirm
    @datum = LendingDatum.new(author_params)
    render :new unless @datum.valid?
  end

  def create
    @datum = LendingDatum.new(author_params)
    return render :new unless @datum.save

    redirect_to authors_path, flash: { success: '登録しました' }
  end

  def edit
    @datum = LendingDatum.find(params[:id])
  end

  def edit_confirm
    @datum = LendingDatum.find(params[:id])
    @datum.attributes = author_params
    render :new unless @datum.valid?
  end

  def update
    @datum = LendingDatum.find(params[:id])
    @datum.attributes = author_params
    return render :edit unless @datum.save

    redirect_to authors_path, flash: { success: '更新しました' }
  end

  def destroy
    LendingDatum.find(params[:id]).destroy
    redirect_to authors_path, flash: { success: '削除しました' }
  end
end
