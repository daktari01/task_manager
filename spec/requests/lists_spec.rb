require 'rails_helper'

RSpec.describe "Lists", type: :request do
  let(:valid_attributes) do
    { title: 'Test List', description: 'This is a test list' }
  end

  let(:invalid_attributes) do
    { title: '', description: '' }
  end

  let!(:list) { List.create!(valid_attributes) }

  describe 'GET /lists' do
    it 'returns http success' do
      get lists_path
      expect(response).to have_http_status(:success)
    end

    it 'displays the list title' do
      get lists_path
      expect(response.body).to include(list.title)
    end
  end

  describe 'GET /lists/:id' do
    it 'returns http success' do
      get list_path(list)
      expect(response).to have_http_status(:success)
    end

    it 'displays the list details' do
      get list_path(list)
      expect(response.body).to include(list.title)
      expect(response.body).to include(list.description)
    end
  end

  describe 'GET /lists/new' do
    it 'returns http success' do
      get new_list_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /lists/:id/edit' do
    it 'returns http success' do
      get edit_list_path(list)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /lists' do
    context 'with valid parameters' do
      it 'creates a new list' do
        expect {
          post lists_path, params: { list: valid_attributes }
        }.to change(List, :count).by(1)
      end

      it 'redirects to the created list' do
        post lists_path, params: { list: valid_attributes }
        expect(response).to redirect_to(list_path(List.last))
      end

      it 'sets a success flash message' do
        post lists_path, params: { list: valid_attributes }
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new list' do
        expect {
          post lists_path, params: { list: invalid_attributes }
        }.not_to change(List, :count)
      end

      it 'returns unprocessable_entity status' do
        post lists_path, params: { list: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /lists/:id' do
    let(:new_attributes) do
      { title: 'Updated List Title', description: 'Updated description' }
    end

    context 'with valid parameters' do
      it 'updates the requested list' do
        patch list_path(list), params: { list: new_attributes }
        list.reload
        expect(list.title).to eq('Updated List Title')
        expect(list.description).to eq('Updated description')
      end

      it 'redirects to the list' do
        patch list_path(list), params: { list: new_attributes }
        expect(response).to redirect_to(list_path(list))
      end

      it 'sets a success flash message' do
        patch list_path(list), params: { list: new_attributes }
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid parameters' do
      it 'does not update the list' do
        original_title = list.title
        patch list_path(list), params: { list: invalid_attributes }
        list.reload
        expect(list.title).to eq(original_title)
      end

      it 'returns unprocessable_entity status' do
        patch list_path(list), params: { list: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /lists/:id' do
    it 'destroys the requested list' do
      expect {
        delete list_path(list)
      }.to change(List, :count).by(-1)
    end

    it 'redirects to the lists index' do
      delete list_path(list)
      expect(response).to redirect_to(lists_path)
    end

    it 'sets a success flash message' do
      delete list_path(list)
      expect(flash[:notice]).to be_present
    end
  end
end