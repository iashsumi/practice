class PublishersController < ApplicationController
  def index
    @publishers = Publisher.page(params[:page]).per(20)
  end

  def show
    @publisher = Publisher.find(params[:id])
  end

  def new
    @publisher = Publisher.new
  end

  def new_confirm
    @publisher = Publisher.new(author_params)
    render :new unless @publisher.valid?
  end

  def create
    @publisher = Publisher.new(author_params)
    return render :new unless @publisher.save

    redirect_to authors_path, flash: { success: '登録しました' }
  end

  def edit
    @publisher = Publisher.find(params[:id])
  end

  def edit_confirm
    @publisher = Publisher.find(params[:id])
    @publisher.attributes = author_params
    render :new unless @publisher.valid?
  end

  def update
    @publisher = Publisher.find(params[:id])
    @publisher.attributes = author_params
    return render :edit unless @publisher.save

    redirect_to authors_path, flash: { success: '更新しました' }
  end

  def destroy
    Publisher.find(params[:id]).destroy
    redirect_to authors_path, flash: { success: '削除しました' }
  end
end
