class BooksController < ApplicationController
  def index
    @books = Book.page(params[:page]).per(20)
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def new_confirm
    @book = Book.new(author_params)
    render :new unless @book.valid?
  end

  def create
    @book = Book.new(author_params)
    return render :new unless @book.save

    redirect_to authors_path, flash: { success: '登録しました' }
  end

  def edit
    @book = Book.find(params[:id])
  end

  def edit_confirm
    @book = Book.find(params[:id])
    @book.attributes = author_params
    render :new unless @book.valid?
  end

  def update
    @book = Book.find(params[:id])
    @book.attributes = author_params
    return render :edit unless @book.save

    redirect_to authors_path, flash: { success: '更新しました' }
  end

  def destroy
    Book.find(params[:id]).destroy
    redirect_to authors_path, flash: { success: '削除しました' }
  end
end
