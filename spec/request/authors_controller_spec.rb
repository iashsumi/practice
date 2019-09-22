require 'rails_helper'

RSpec.describe AuthorsController, type: :request do
  describe 'GET #index' do
    before do
      create(:author, name: 'test_name')
    end

    before do
      get authors_url
    end

    it 'success' do
      expect(response.status).to eq 200
    end

    it 'Author name is displayed' do
      expect(response.body).to include 'test_name'
    end
  end

  describe 'GET #show' do
    context 'If the author exists' do
      let!(:author) { create(:author, name: 'test_name') }

      before do
        get author_url(author.id)
      end

      it 'success' do
        expect(response.status).to eq 200
      end

      it 'Author name is displayed' do
        expect(response.body).to include 'test_name'
      end
    end

    context "If the author does't exist" do
      subject { -> { get author_url(1) } }
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
        post new_confirm_authors_url, params: { author: attributes_for(:author, name: 'test_name') }
      end

      it 'success' do
        expect(response.status).to eq 200
      end

      it 'Author name is displayed' do
        expect(response.body).to include 'test_name'
      end
    end
  end

  describe 'POST #create' do
    context 'When parameters are valid' do
      it 'success' do
        post authors_url, params: { author: attributes_for(:author) }
        expect(response.status).to eq 302
      end

      it 'User registration' do
        expect do
          post authors_url, params: { author: attributes_for(:author) }
        end.to change(Author, :count).by(1)
      end

      it 'Redirect' do
        post authors_url, params: { author: attributes_for(:author) }
        expect(response).to redirect_to authors_url
      end
    end

    context 'If the parameter is invalid' do
      it 'success' do
        post authors_url, params: { author: attributes_for(:author, :invalid) }
        expect(response.status).to eq 200
      end

      it 'The author is not registered' do
        expect do
          post authors_url, params: { author: attributes_for(:author, :invalid) }
        end.to_not change(User, :count)
      end

      it 'An error is displayed' do
        post authors_url, params: { author: attributes_for(:author, :invalid) }
        expect(response.body).to include '新規登録'
      end
    end
  end

  describe 'GET #edit' do
    let(:oda) { create(:author, :oda) }
    it 'success' do
      get edit_author_url(oda)
      expect(response.status).to eq 200
    end
  end

  describe 'PATCH #edit_confirm' do
    let(:oda) { create(:author, :oda) }
    context 'When parameters are valid' do
      before do
        patch edit_confirm_author_url(oda), params: { author: attributes_for(:author, :test) }
      end

      it 'success' do
        expect(response.status).to eq 200
      end

      it 'Author name is displayed' do
        expect(response.body).to include 'test'
      end
    end
  end

  describe 'PATCH #update' do
    let(:oda) { create(:author, :oda) }
    context 'When parameters are valid' do
      it 'success' do
        patch author_url(oda), params: { author: attributes_for(:author, :test) }
        expect(response.status).to eq 302
      end

      it 'Author registration' do
        expect do
          patch author_url(oda), params: { author: attributes_for(:author, :test) }
        end.to change { Author.find(oda.id).name }.from('oda').to('test')
      end

      it 'Redirect' do
        patch author_url(oda), params: { author: attributes_for(:author, :test) }
        expect(response).to redirect_to authors_url
      end
    end

    context 'If the parameter is invalid' do
      it 'success' do
        patch author_url(oda), params: { author: attributes_for(:author, :invalid) }
        expect(response.status).to eq 200
      end

      it 'The author is not registered' do
        expect do
          patch author_url(oda), params: { author: attributes_for(:author, :invalid) }
        end.to_not change(Author.find(oda.id), :name)
      end

      it 'An error is displayed' do
        patch author_url(oda), params: { author: attributes_for(:author, :invalid) }
        expect(response.body).to include '編集'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:author) { create(:author) }

    it 'The request is successful' do
      delete author_url(author)
      expect(response.status).to eq 302
    end

    it 'The author is deleted' do
      expect do
        delete author_url(author)
      end.to change(Author, :count).by(-1)
    end

    it 'Redirect to author list' do
      delete author_url(author)
      expect(response).to redirect_to(authors_url)
    end
  end
end
