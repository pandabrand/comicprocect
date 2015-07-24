#config.ru
$: << File.dirname(__FILE__)
require './comic_app.rb'
run ComicApp.new
