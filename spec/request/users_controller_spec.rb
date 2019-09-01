require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #index' do
    before do
      create(:user, name: 'test_name')
    end

    before do
      get users_url
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
      let!(:user) { create(:user, name: 'test_name') }

      before do
        get user_url(user.id)
      end

      it 'success' do
        expect(response.status).to eq 200
      end

      it 'User name is displayed' do
        expect(response.body).to include 'test_name'
      end
    end

    context "If the user does't exist" do
      subject { -> { get user_url(1) } }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'GET #new' do
    it 'success' do
      get new_user_url
      expect(response.status).to eq 200
    end
  end

  describe 'POST #new_confirm' do
    context 'When parameters are valid' do
      before do
        post new_confirm_users_url, params: { user: attributes_for(:user, name: 'test_name') }
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
        post users_url, params: { user: attributes_for(:user) }
        expect(response.status).to eq 302
      end

      it 'User registration' do
        expect do
          post users_url, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
      end

      it 'Redirect' do
        post users_url, params: { user: attributes_for(:user) }
        expect(response).to redirect_to users_url
      end
    end

    context 'If the parameter is invalid' do
      it 'success' do
        post users_url, params: { user: attributes_for(:user, :invalid) }
        expect(response.status).to eq 200
      end

      it 'The user is not registered' do
        expect do
          post users_url, params: { user: attributes_for(:user, :invalid) }
        end.to_not change(User, :count)
      end

      it 'An error is displayed' do
        post users_url, params: { user: attributes_for(:user, :invalid) }
        expect(response.body).to include '新規登録'
      end
    end
  end

  describe 'GET #edit' do
    let(:admin) { create(:user, :admin) }
    it 'success' do
      get edit_user_url(admin)
      expect(response.status).to eq 200
    end
  end

  describe 'PATCH #edit_confirm' do
    let(:admin) { create(:user, :admin) }
    context 'When parameters are valid' do
      before do
        patch edit_confirm_user_url(admin), params: { user: attributes_for(:user, :test) }
      end

      it 'success' do
        expect(response.status).to eq 200
      end

      it 'User name is displayed' do
        expect(response.body).to include 'test'
      end
    end
  end

  describe 'PATCH #update' do
    let(:admin) { create(:user, :admin) }
    context 'When parameters are valid' do
      it 'success' do
        patch user_url(admin), params: { user: attributes_for(:user, :test) }
        expect(response.status).to eq 302
      end

      it 'User registration' do
        expect do
          patch user_url(admin), params: { user: attributes_for(:user, :test) }
        end.to change { User.find(admin.id).name }.from('admin').to('test')
      end

      it 'Redirect' do
        patch user_url(admin), params: { user: attributes_for(:user, :test) }
        expect(response).to redirect_to users_url
      end
    end

    context 'If the parameter is invalid' do
      it 'success' do
        patch user_url(admin), params: { user: attributes_for(:user, :invalid) }
        expect(response.status).to eq 200
      end

      it 'The user is not registered' do
        expect do
          patch user_url(admin), params: { user: attributes_for(:user, :invalid) }
        end.to_not change(User.find(admin.id), :name)
      end

      it 'An error is displayed' do
        patch user_url(admin), params: { user: attributes_for(:user, :invalid) }
        expect(response.body).to include '編集'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }

    it 'The request is successful' do
      delete user_url(user)
      expect(response.status).to eq 302
    end

    it 'The user is deleted' do
      expect do
        delete user_url(user)
      end.to change(User, :count).by(-1)
    end

    it 'Redirect to user list' do
      delete user_url(user)
      expect(response).to redirect_to(users_url)
    end
  end

  describe 'POST #import' do
    let(:upload_file) { {file: fixture_file_upload('users/users.csv', "text/csv")} }

    it 'The request is successful' do
      expect do
        post import_users_url, { params: upload_file }
      end.to change(User, :count).by(2)
    end
  end
end
