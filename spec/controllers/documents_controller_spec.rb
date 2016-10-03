require 'rails_helper'

RSpec.describe DocumentsController, type: :controller do
  describe 'documents#index' do
    it 'should successfully load the homepage' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'documents#new' do
    it 'should show the new document form if admin is signed in' do
      user = FactoryGirl.create(:user, admin: true)
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end

    it 'should return unauthorized if user is not admin' do
      user = FactoryGirl.create(:user)
      sign_in user

      get :new
      expect(response).to have_http_status(:unauthorized)
    end
    it 'should redirect to sign_in page if user is not signed in' do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'documents#create' do
    it 'should properly deal with validation errors' do
      user = FactoryGirl.create(:user, admin: true)
      sign_in user

      post :create, params: { document: { title: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Document.count).to eq 0
    end

    it 'should not allow non-admin users to create documents' do
      user = FactoryGirl.create(:user)
      sign_in user

      post :create, params:
        { document:
          { title: 'Hello!',
            file: fixture_file_upload('/sample.png', 'image/png') } }
      expect(response).to have_http_status(:unauthorized)
      expect(Document.count).to eq 0
    end
    it 'should successfully create a new document in our database' do
      user = FactoryGirl.create(:user, admin: true)
      sign_in user

      post :create, params: { document:
        { title: 'Hello!',
          file: fixture_file_upload('/sample.png', 'image/png') } }

      expect(response).to redirect_to documents_path

      doc = Document.last
      expect(doc.title).to eq('Hello!')
      expect(doc.user).to eq(user)
    end
  end
end
