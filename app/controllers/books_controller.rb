class BooksController < ApplicationController
  before_action :set_publishers, only: %i[new new_confirm create edit edit_confirm update]
  before_action :set_authors, only: %i[new new_confirm create edit edit_confirm update]

  def index
    @q = Book.ransack(params)
    @books = @q.result(distinct: true).page(params[:page])
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def new_confirm
    @book = Book.new(book_params)
    render :new unless @book.valid?
  end

  def create
    @book = Book.new(book_params)
    return render :new unless @book.save

    redirect_to books_path, flash: { success: '登録しました' }
  end

  def edit
    @book = Book.find(params[:id])
  end

  def edit_confirm
    @book = Book.find(params[:id])
    @book.attributes = book_params
    render :edit unless @book.valid?
  end

  def update
    @book = Book.find(params[:id])
    @book.attributes = book_params
    return render :edit unless @book.save

    redirect_to books_path, flash: { success: '更新しました' }
  end

  def destroy
    Book.find(params[:id]).destroy
    redirect_to books_path, flash: { success: '削除しました' }
  end

  private

  def book_params
    params.require(:book).permit(
      :id,
      :title,
      :publisher_id,
      :author_id,
      :release_date
    )
  end

  def set_publishers
    @publishers = Publisher.all.pluck(:name, :id)
  end

  def set_authors
    @authors = Author.all.pluck(:name, :id)
  end
end
