require 'rails_helper'

describe API::V1::HeartbeatController do
  describe 'GET status' do
    before { get 'status' }

    it 'is success' do
      expect(response.status).to eql 200 # success
    end

    it 'is JSON respnose content type' do
      expect(response.content_type).to eql 'application/json'
    end

    it 'has status OK' do
      expect(json_response[:status]).to eq 'OK'
    end
  end
end
