# frozen_string_literal: true

require './app'

RSpec.describe App do
  include Rack::Test::Methods

  def app
    App.new
  end

  describe 'GET status' do
    before(:each) { get '/' }

    it 'is success' do
      expect(last_response.status).to eql 200
    end

    it 'is JSON respnose content type' do
      expect(last_response.content_type).to eql 'application/json'
    end

    it 'has OK status' do
      expect(json_response[:status]).to eq 'OK'
    end
  end

  def json_response
    JSON.parse(last_response.body, symbolize_names: true)
  end
end
