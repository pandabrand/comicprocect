#comic_app.rb

require 'sinatra/base'
require_relative 'routes/init'

class ComicApp < Sinatra::Base
  configure do
    set :app_file, __FILE__
    set :public_dir, File.dirname(__FILE__) + '/static'
    if !Dir.exist?(File.join(settings.public_dir, 'authors'))
      Dir.mkdir(File.join(settings.public_dir, 'authors'))
    end
    set :authors, Proc.new { Dir.entries(File.join(settings.public_dir, 'authors')).select {|entry| File.directory? File.join(settings.public_dir, 'authors',entry) and !(entry =='.' || entry == '..') } }
  end

  configure :developement do
    enable :logging, :dump_errors, :raise_errors
  end

  configure :production do
    set :raise_errors, false
    set :show_exceptions, false
  end
  def author_name(index)
    name_array = settings.authors[index].split('_')
    return name_array[1].capitalize + ' ' + name_array[0].capitalize
  end
end
