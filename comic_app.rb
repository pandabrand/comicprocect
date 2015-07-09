#comic_app.rb

require 'sinatra/base'

class ComicApp < Sinatra::Base
  get '/' do
    "Hello World"
  end
  
  get '/hi' do
    "Test"
  end
end