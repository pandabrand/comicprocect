class ComicApp < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/:author' do
    @author = params['author']
    @authors = settings.author_list.select{ |key,value| value == @author }
    if(@authors.empty?)
      erb :error_page
    else
      @images = Dir.entries(File.join('authors', @author)).select {|entry| File.file? File.join('authors',@author,entry) and !(entry =='.' || entry == '..'|| entry == 'author.txt' || entry =~ /_thumb/) }
      @author_info = Array.new
      IO.foreach(File.join('authors', @author, 'author.txt')){|line| @author_info.push(line)}
      erb :comic
    end
  end

  not_found do
    erb :error_page
  end
end
