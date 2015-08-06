class ComicApp < Sinatra::Base
  get '/' do
    @author_keys = settings.author_list.keys.sort_by do |name|
      name.split(" ").reverse.join(",")
    end
    erb :index
  end

  get '/hi' do
    "Test"
  end

  get '/:author' do
    author = params['author']
    @authors = settings.author_list.select{ |key,value| value == author }
    if(@authors.empty?)
      erb :error_page
    else
      erb :comic
    end
  end

  not_found do
    erb :error_page
  end
end
