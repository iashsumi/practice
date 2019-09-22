class LendingDatumController < ApplicationController
  before_action :set_users, only: [:new_header]
  before_action :set_publishers, only: [:new_book_select]
  before_action :set_authors, only: [:new_book_select]
  before_action :cookies_init, only: [:new_header]

  def index
    @lending_data = LendingDatum.page(params[:page])
  end

  def show
    @lending_datum = LendingDatum.find(params[:id])
  end

  def new_header
    @lending_datum = LendingDatum.new
  end

  def new_book_select
    @lending_datum = LendingDatum.new(lending_datum_params)
    @books = Book.all.page(params[:page])
  end

  def new_confirm
    @lending_datum = LendingDatum.new(lending_datum_params)
    render :new unless @lending_datum.valid?
  end

  def create
    @lending_datum = LendingDatum.new(lending_datum_params)
    return render :new unless @lending_datum.save

    redirect_to lending_data_path, flash: { success: '登録しました' }
  end

  def edit
    @lending_datum = LendingDatum.find(params[:id])
  end

  def edit_confirm
    @lending_datum = LendingDatum.find(params[:id])
    @lending_datum.attributes = lending_datum_params
    render :edit unless @lending_datum.valid?
  end

  def update
    @lending_datum = LendingDatum.find(params[:id])
    @lending_datum.attributes = lending_datum_params
    return render :edit unless @lending_datum.save

    redirect_to lending_data_path, flash: { success: '更新しました' }
  end

  def destroy
    LendingDatum.find(params[:id]).destroy
    redirect_to lending_data_path, flash: { success: '削除しました' }
  end

  def add_book
    a = cookies.encrypted[:selected_books]
    a << book_params[:add_id]
    cookies.encrypted[:selected_books] = a
    @selected_books = Book.where(id: a)
  end

  def delete_book
    a = cookies.encrypted[:selected_books]
    a.delete(params[:id])
    cookies.encrypted[:selected_books] = a
    @selected_books = Book.where(id: a)
  end

  def books
    @q = Book.ransack(params)
    @books = @q.result(distinct: true).page(params[:page])
    # render json: {result: "ok", books: @books}
  end

  private

  def lending_datum_params
    params.require(:lending_datum).permit(
      :id,
      :user_id,
      :checkout_date,
      :return_date
    )
  end

  def book_params
    params.require(:book).permit(:add_id)
  end

  def set_users
    @users = User.all.pluck(:name, :id)
  end

  def set_publishers
    @publishers = Publisher.all.pluck(:name, :id)
  end

  def set_authors
    @authors = Author.all.pluck(:name, :id)
  end

  def cookies_init
    cookies.encrypted[:selected_books] = []
  end
end
