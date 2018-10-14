require 'rails_helper'

describe API::V1::HomesController do
  describe 'GET search' do
    before do
      allow_any_instance_of(MasClient).to receive(:build)
        .and_return(en: 'La La Land')
      get 'search', query: 'string-to-search'
    end

    it 'is success' do
      expect(response.status).to eql 200 # success
    end

    it 'is JSON respnose content type' do
      expect(response.content_type).to eql 'application/json'
    end

    it 'renders response from MasClient' do
      expect(json_response).to eq(en: 'La La Land')
    end

    it 'assigns query instance variable' do
      expect(assigns(:query)).to eq('string-to-search')
    end
  end

  describe 'GET status' do
    before do
      allow(MasClient).to receive(:status).and_return(en: 'Player One')
      get :status
    end

    it 'is success' do
      expect(response.status).to eql 200 # success
    end

    it 'is JSON respnose content type' do
      expect(response.content_type).to eql 'application/json'
    end

    it 'has status OK' do
      expect(json_response).to eq(en: 'Player One') 
    end
  end
end
