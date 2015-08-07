#comic_app.rb

require 'sinatra/base'
require_relative 'routes/init'

class ComicApp < Sinatra::Base

  configure do
    set :root,File.dirname(__FILE__)
    set :app_file, __FILE__
    set :public_dir, File.dirname(__FILE__) + '/static'
    if !Dir.exist?('authors')
      Dir.mkdir('authors')
    end
    set :authors, Proc.new { Dir.entries(File.join('authors')).select {|entry| File.directory? File.join('authors',entry) and !(entry =='.' || entry == '..') } }
    set :author_list, Proc.new {
      al = Hash.new
      settings.authors.each do |name|
        if(name.include? "-")
          name_array = name.split("-")
          al[author_name(name_array[0])] = name
          al[author_name(name_array[1])] = name
        else
          al[author_name(name)] = name
        end
      end
      return al
    }
  end

  configure :developement do
    enable :logging, :dump_errors, :raise_errors
  end

  configure :production do
    set :raise_errors, false
    set :show_exceptions, false
  end

  def self.author_name(name)
    name_array = name.split('_')
    name_array.reverse!
    name_array.select { |e| e.capitalize! }
    return name_array.join(" ")
  end

  def author_keys
    akeys = settings.author_list.keys.sort_by do |name|
      name.split(" ").reverse.join(",")
    end
    akeys
  end

  def thumbnail(image)
    imagename = image.split(".")
    return imagename[0] + '_thumb.' + imagename[1]
  end
end
