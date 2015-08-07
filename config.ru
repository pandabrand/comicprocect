#config.ru
ENV['GEM_HOME'] = '/home/pandabrand/.gems'
ENV['GEM_PATH'] = '$GEM_HOME:/usr/lib/ruby/gems/1.8'
require 'rubygems'
Gem.clear_paths

require '/home/pandabrand/.gems/gems/rack-1.6.4/lib/rack.rb'
require '/home/pandabrand/.gems/gems/sinatra-1.4.6/lib/sinatra.rb'

set :environment, :development

$: << File.dirname(__FILE__)
#require './comic_app.rb'
require File.expand_path '../comic_app.rb', __FILE__

run ComicApp.new

map "/css" do
  run Rack::Directory.new("./static/css")
end

map "/img" do
  run Rack::Directory.new("./static/img")
end

map "/authors" do
  run Rack::Directory.new("./authors")
end

map "/js" do
  run Rack::Directory.new("./static/js")
end
