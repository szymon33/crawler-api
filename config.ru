require "./app.rb"

map '/api/v1' do
  run App
end
