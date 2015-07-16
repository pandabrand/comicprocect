#comic_app.rb

require 'sinatra/base'

class ComicApp < Sinatra::Base
  set :static, true
  set :public, File.dirname(__FILE__) + '/static'
  
  get '/' do
    "Hello World"
  end
  
  get '/hi' do
    "Test"
  end
  
  get '/:author' do
    author = params['author']
    redirect "/" + author + "/1"
  end
  
  get ':author/:page' do
    author = params['author']
    author
  end
end