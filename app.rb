# frozen_string_literal: true

require './config/environment'

class App < Sinatra::Base
  before do
    content_type 'application/json'
  end

  # the purpose of this action is to check the status of API
  get '/' do
    { status: 'OK' }.to_json
  end
end

App.run! if $PROGRAM_NAME == __FILE__
