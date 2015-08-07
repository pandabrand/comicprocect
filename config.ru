#config.ru
$: << File.dirname(__FILE__)
require './comic_app.rb'
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
