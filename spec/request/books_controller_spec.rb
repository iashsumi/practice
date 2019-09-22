require 'rails_helper'

RSpec.describe BooksController, type: :request do
  describe 'GET #index' do
    before do
      create(:book, title: 'test_name')
    end

    before do
      get books_url
    end

    it 'success' do
      expect(response.status).to eq 200
    end

    it 'Book title is displayed' do
      expect(response.body).to include 'test_name'
    end
  end

  describe 'GET #show' do
    context 'If the book exists' do
      let!(:book) { create(:book, title: 'test_name') }

      before do
        get book_url(book.id)
      end

      it 'success' do
        expect(response.status).to eq 200
      end

      it 'Book title is displayed' do
        expect(response.body).to include 'test_name'
      end
    end

    context "If the book does't exist" do
      subject { -> { get book_url(1) } }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'GET #new' do
    it 'success' do
      get new_author_url
      expect(response.status).to eq 200
    end
  end

  describe 'POST #new_confirm' do
    context 'When parameters are valid' do
      before do
        post new_confirm_books_url, params: { book: attributes_for(:book, title: 'test_name') }
      end

      it 'success' do
        expect(response.status).to eq 200
      end

      it 'Book title is displayed' do
        expect(response.body).to include 'test_name'
      end
    end
  end

  describe 'POST #create' do
    context 'When parameters are valid' do
      let!(:publisher) { create(:publisher, name: 'test_name') }
      let!(:author) { create(:author, name: 'test_name') }
      it 'success' do
        post books_url, params: { book: attributes_for(:book, publisher_id: publisher.id, author_id: author.id) }
        expect(response.status).to eq 302
      end

      it 'Book registration' do
        expect do
          post books_url, params: { book: attributes_for(:book, publisher_id: publisher.id, author_id: author.id) }
        end.to change(Book, :count).by(1)
      end

      it 'Redirect' do
        post books_url, params: { book: attributes_for(:book, publisher_id: publisher.id, author_id: author.id) }
        expect(response).to redirect_to books_url
      end
    end

    context 'If the parameter is invalid' do
      it 'success' do
        post books_url, params: { book: attributes_for(:book, :invalid) }
        expect(response.status).to eq 200
      end

      it 'The book is not registered' do
        expect do
          post books_url, params: { book: attributes_for(:book, :invalid) }
        end.to_not change(Book, :count)
      end

      it 'An error is displayed' do
        post books_url, params: { book: attributes_for(:book, :invalid) }
        expect(response.body).to include '新規登録'
      end
    end
  end

  describe 'GET #edit' do
    let(:one_peace) { create(:book, :one_peace) }
    it 'success' do
      get edit_book_url(one_peace)
      expect(response.status).to eq 200
    end
  end

  describe 'PATCH #edit_confirm' do
    let(:one_peace) { create(:book, :one_peace) }
    context 'When parameters are valid' do
      before do
        patch edit_confirm_book_url(one_peace), params: { book: attributes_for(:book, :test) }
      end

      it 'success' do
        expect(response.status).to eq 200
      end

      it 'Book title is displayed' do
        expect(response.body).to include 'test'
      end
    end
  end

  describe 'PATCH #update' do
    let(:one_peace) { create(:book, :one_peace) }
    context 'When parameters are valid' do
      it 'success' do
        patch book_url(one_peace), params: { book: attributes_for(:book, :test) }
        expect(response.status).to eq 302
      end

      it 'Book registration' do
        expect do
          patch book_url(one_peace), params: { book: attributes_for(:book, :test) }
        end.to change { Book.find(one_peace.id).title }.from('one_peace').to('test')
      end

      it 'Redirect' do
        patch book_url(one_peace), params: { book: attributes_for(:book, :test) }
        expect(response).to redirect_to books_url
      end
    end

    context 'If the parameter is invalid' do
      it 'success' do
        patch book_url(one_peace), params: { book: attributes_for(:book, :invalid) }
        expect(response.status).to eq 200
      end

      it 'The book is not registered' do
        expect do
          patch book_url(one_peace), params: { book: attributes_for(:book, :invalid) }
        end.to_not change(Book.find(one_peace.id), :title)
      end

      it 'An error is displayed' do
        patch book_url(one_peace), params: { book: attributes_for(:book, :invalid) }
        expect(response.body).to include '編集'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:book) { create(:book) }

    it 'The request is successful' do
      delete book_url(book)
      expect(response.status).to eq 302
    end

    it 'The book is deleted' do
      expect do
        delete book_url(book)
      end.to change(Book, :count).by(-1)
    end

    it 'Redirect to book list' do
      delete book_url(book)
      expect(response).to redirect_to(books_url)
    end
  end
end
