require 'rails_helper'

describe API::V1::APIController do
  describe 'Handling not found exception' do
    controller do
      def index
        render_not_found
      end
    end

    before { get :index }

    it 'has 404 code' do
      expect(response.status).to eql 404 # not found
    end

    it 'is JSON respnose content type' do
      get :index
      expect(response.content_type).to eql 'application/json'
    end

    it 'has status OK' do
      expect(json_response).to eq(error: 'Not Found')
    end
  end
end
