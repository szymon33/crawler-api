require 'rails_helper'

describe API::V1::HomesController do
  describe 'GET search' do
    before { get 'search' }

    it 'is success' do
      expect(response.status).to eql 200 # success
    end

    it 'is JSON respnose content type' do
      expect(response.content_type).to eql 'application/json'
    end

    it 'has OK body' do
      expect(json_response[:message]).to eq 'OK'
    end
  end
end
