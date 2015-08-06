class ComicApp < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/hi' do
    "Test"
  end

  get '/:author' do
    author = params['author']
    redirect "/" + author
  end

  not_found do
    erb :error_page
  end
end
