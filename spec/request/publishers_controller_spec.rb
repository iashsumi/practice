require 'rails_helper'

RSpec.describe PublishersController, type: :request do
  describe 'GET #index' do
    before do
      create(:publisher, name: 'test_name')
    end

    before do
      get publishers_url
    end

    it 'success' do
      expect(response.status).to eq 200
    end

    it 'Publisher name is displayed' do
      expect(response.body).to include 'test_name'
    end
  end

  describe 'GET #show' do
    context 'If the publisher exists' do
      let!(:publisher) { create(:publisher, name: 'test_name') }

      before do
        get publisher_url(publisher.id)
      end

      it 'success' do
        expect(response.status).to eq 200
      end

      it 'Publisher name is displayed' do
        expect(response.body).to include 'test_name'
      end
    end

    context "If the publisher does't exist" do
      subject { -> { get publisher_url(1) } }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'GET #new' do
    it 'success' do
      get new_publisher_url
      expect(response.status).to eq 200
    end
  end

  describe 'POST #new_confirm' do
    context 'When parameters are valid' do
      before do
        post new_confirm_publishers_url, params: { publisher: attributes_for(:publisher, name: 'test_name') }
      end

      it 'success' do
        expect(response.status).to eq 200
      end

      it 'Publisher name is displayed' do
        expect(response.body).to include 'test_name'
      end
    end
  end

  describe 'POST #create' do
    context 'When parameters are valid' do
      it 'success' do
        post publishers_url, params: { publisher: attributes_for(:publisher) }
        expect(response.status).to eq 302
      end

      it 'User registration' do
        expect do
          post publishers_url, params: { publisher: attributes_for(:publisher) }
        end.to change(Publisher, :count).by(1)
      end

      it 'Redirect' do
        post publishers_url, params: { publisher: attributes_for(:publisher) }
        expect(response).to redirect_to publishers_url
      end
    end

    context 'If the parameter is invalid' do
      it 'success' do
        post publishers_url, params: { publisher: attributes_for(:publisher, :invalid) }
        expect(response.status).to eq 200
      end

      it 'The publisher is not registered' do
        expect do
          post publishers_url, params: { publisher: attributes_for(:publisher, :invalid) }
        end.to_not change(User, :count)
      end

      it 'An error is displayed' do
        post publishers_url, params: { publisher: attributes_for(:publisher, :invalid) }
        expect(response.body).to include '新規登録'
      end
    end
  end

  describe 'GET #edit' do
    let(:company) { create(:publisher, :company) }
    it 'success' do
      get edit_publisher_url(company)
      expect(response.status).to eq 200
    end
  end

  describe 'PATCH #edit_confirm' do
    let(:company) { create(:publisher, :company) }
    context 'When parameters are valid' do
      before do
        patch edit_confirm_publisher_url(company), params: { publisher: attributes_for(:publisher, :test) }
      end

      it 'success' do
        expect(response.status).to eq 200
      end

      it 'Publisher name is displayed' do
        expect(response.body).to include 'test'
      end
    end
  end

  describe 'PATCH #update' do
    let(:company) { create(:publisher, :company) }
    context 'When parameters are valid' do
      it 'success' do
        patch publisher_url(company), params: { publisher: attributes_for(:publisher, :test) }
        expect(response.status).to eq 302
      end

      it 'Publisher registration' do
        expect do
          patch publisher_url(company), params: { publisher: attributes_for(:publisher, :test) }
        end.to change { Publisher.find(company.id).name }.from('company').to('test')
      end

      it 'Redirect' do
        patch publisher_url(company), params: { publisher: attributes_for(:publisher, :test) }
        expect(response).to redirect_to publishers_url
      end
    end

    context 'If the parameter is invalid' do
      it 'success' do
        patch publisher_url(company), params: { publisher: attributes_for(:publisher, :invalid) }
        expect(response.status).to eq 200
      end

      it 'The publisher is not registered' do
        expect do
          patch publisher_url(company), params: { publisher: attributes_for(:publisher, :invalid) }
        end.to_not change(Publisher.find(company.id), :name)
      end

      it 'An error is displayed' do
        patch publisher_url(company), params: { publisher: attributes_for(:publisher, :invalid) }
        expect(response.body).to include '編集'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:publisher) { create(:publisher) }

    it 'The request is successful' do
      delete publisher_url(publisher)
      expect(response.status).to eq 302
    end

    it 'The publisher is deleted' do
      expect do
        delete publisher_url(publisher)
      end.to change(Publisher, :count).by(-1)
    end

    it 'Redirect to publisher list' do
      delete publisher_url(publisher)
      expect(response).to redirect_to(publishers_url)
    end
  end
end
