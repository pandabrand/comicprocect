#comic_app.rb

require 'sinatra/base'

class ComicApp < Sinatra::Base
  set :static, true
  set :public_dir, File.dirname(__FILE__) + '/static'
  if !Dir.exist?(File.join(settings.public_dir, 'authors'))
    Dir.mkdir(File.join(app.settings.public_dir, 'authors'))
  end
  set :authors, Proc.new { Dir.entries(File.join(settings.public_dir, 'authors')).select {|entry| File.directory? File.join(settings.public_dir, 'authors',entry) and !(entry =='.' || entry == '..') } }

  def author_name(index)
    name_array = settings.authors[index].split('_')
    return name_array[1].capitalize + ' ' + name_array[0].capitalize
  end
  
  get '/' do
    "John Biggers"
  end
  
  get '/hi' do
    "Test"
  end
  
  get '/:author' do
    author = params['author']
    redirect "/" + author + "/1"
  end
  
  get '/:author/:page' do
    @author = params['author']
    @page = params['page']
    @author + ' page ' + @page
  end
end