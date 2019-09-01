require 'rails_helper'

RSpec.describe ActiveStragePracticesController, type: :request do
  describe 'GET #index' do
    before do
      create(:active_strage_practice, name: 'test_name')
    end

    before do
      get active_strage_practices_url
    end

    it 'success' do
      expect(response.status).to eq 200
    end

    it 'User name is displayed' do
      expect(response.body).to include 'test_name'
    end
  end

  describe 'GET #show' do
    context 'If the user exists' do
      let!(:target) { create(:active_strage_practice, name: 'test_name') }

      before do
        get active_strage_practices_url(target.id)
      end

      it 'success' do
        expect(response.status).to eq 200
      end

      it 'User name is displayed' do
        expect(response.body).to include 'test_name'
      end
    end

    context "If the user does't exist" do
      subject { -> { get active_strage_practice_url(1) } }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'GET #new' do
    it 'success' do
      get new_active_strage_practice_url
      expect(response.status).to eq 200
    end
  end

  describe 'POST #new_confirm' do
    context 'When parameters are valid' do
      before do
        post new_confirm_active_strage_practices_url, params: { active_strage_practice: attributes_for(:active_strage_practice, name: 'test_name') }
      end

      it 'success' do
        expect(response.status).to eq 200
      end

      it 'User name is displayed' do
        expect(response.body).to include 'test_name'
      end
    end
  end

  describe 'POST #create' do
    context 'When parameters are valid' do
      it 'success' do
        post active_strage_practices_url, params: { active_strage_practice: attributes_for(:active_strage_practice) }
        expect(response.status).to eq 302
      end

      it 'User registration' do
        expect do
          post active_strage_practices_url, params: { active_strage_practice: attributes_for(:active_strage_practice) }
        end.to change(ActiveStragePractice, :count).by(1)
      end

      it 'Redirect' do
        post active_strage_practices_url, params: { active_strage_practice: attributes_for(:active_strage_practice) }
        expect(response).to redirect_to active_strage_practices_url
      end
    end

    context 'If the parameter is invalid' do
      it 'success' do
        post active_strage_practices_url, params: { active_strage_practice: attributes_for(:active_strage_practice, :invalid) }
        expect(response.status).to eq 200
      end

      it 'The user is not registered' do
        expect do
          post active_strage_practices_url, params: { active_strage_practice: attributes_for(:active_strage_practice, :invalid) }
        end.to_not change(ActiveStragePractice, :count)
      end

      it 'An error is displayed' do
        post active_strage_practices_url, params: { active_strage_practice: attributes_for(:active_strage_practice, :invalid) }
        expect(response.body).to include '新規登録'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:active_strage_practice) { create(:active_strage_practice) }

    it 'The request is successful' do
      delete active_strage_practice_url(active_strage_practice)
      expect(response.status).to eq 302
    end

    it 'The user is deleted' do
      expect do
        delete active_strage_practice_url(active_strage_practice)
      end.to change(ActiveStragePractice, :count).by(-1)
    end

    it 'Redirect to user list' do
      delete active_strage_practice_url(active_strage_practice)
      expect(response).to redirect_to(active_strage_practices_url)
    end
  end
end
