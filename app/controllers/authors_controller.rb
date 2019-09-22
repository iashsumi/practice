class AuthorsController < ApplicationController
  def index
    @authors = Author.page(params[:page])
  end

  def show
    @author = Author.find(params[:id])
  end

  def new
    @author = Author.new
  end

  def new_confirm
    @author = Author.new(author_params)
    render :new unless @author.valid?
  end

  def create
    @author = Author.new(author_params)
    return render :new unless @author.save

    redirect_to authors_path, flash: { success: '登録しました' }
  end

  def edit
    @author = Author.find(params[:id])
  end

  def edit_confirm
    @author = Author.find(params[:id])
    @author.attributes = author_params
    render :new unless @author.valid?
  end

  def update
    @author = Author.find(params[:id])
    @author.attributes = author_params
    return render :edit unless @author.save

    redirect_to authors_path, flash: { success: '更新しました' }
  end

  def destroy
    Author.find(params[:id]).destroy
    redirect_to authors_path, flash: { success: '削除しました' }
  end

  private

  def author_params
    params.require(:author).permit(
      :id,
      :name
    )
  end
end
