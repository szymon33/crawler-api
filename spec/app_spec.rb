require './app'

RSpec.describe App do
  include Rack::Test::Methods

  def app
    App.new
  end

  describe 'GET root' do
    it 'is successful' do
      get '/'
      expect(last_response).to be_ok
    end
  end

  def json_response
    JSON.parse(last_response.body, symbolize_names: true)
  end
end
