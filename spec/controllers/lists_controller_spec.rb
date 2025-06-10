require 'rails_helper'

RSpec.describe ListsController, type: :controller do
  let(:valid_attributes) {
    { title: 'Test List', description: 'This is a test list' }
  }

  let(:invalid_attributes) {
    { title: '', description: '' }
  }

  let(:valid_session) { {} }
  let!(:list) { List.create!(valid_attributes) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: list.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: list.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new List' do
        expect {
          post :create, params: { list: valid_attributes }, session: valid_session
        }.to change(List, :count).by(1)
      end

      it 'redirects to the created list' do
        post :create, params: { list: valid_attributes }, session: valid_session
        expect(response).to redirect_to(List.last)
      end
    end

    context 'with invalid params' do
      it "does not create a new list and returns unprocessable_entity status" do
        expect {
          post :create, params: { list: invalid_attributes }, session: valid_session
        }.not_to change(List, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { title: 'Updated List', description: 'Updated description' }
      }

      it 'updates the requested list' do
        put :update, params: { id: list.to_param, list: new_attributes }, session: valid_session
        list.reload
        expect(list.title).to eq('Updated List')
        expect(list.description).to eq('Updated description')
      end

      it 'redirects to the list' do
        put :update, params: { id: list.to_param, list: valid_attributes }, session: valid_session
        expect(response).to redirect_to(list)
      end
    end

    context 'with invalid params' do
      it "does not update the list and returns unprocessable_entity status" do
        original_title = list.title
        put :update, params: { id: list.to_param, list: invalid_attributes }, session: valid_session
        list.reload
        expect(list.title).to eq(original_title)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested list' do
      expect {
        delete :destroy, params: { id: list.to_param }, session: valid_session
      }.to change(List, :count).by(-1)
    end

    it 'redirects to the lists list' do
      delete :destroy, params: { id: list.to_param }, session: valid_session
      expect(response).to redirect_to(lists_url)
    end
  end
end
