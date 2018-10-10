# frozen_string_literal: true

require './config/environment'

class App < Sinatra::Base
  get '/' do
    'Hello World!'
  end
end

App.run! if $PROGRAM_NAME == __FILE__
