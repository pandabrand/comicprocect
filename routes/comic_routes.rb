class ComicApp < Sinatra::Base
  get '/' do
    erb :index
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
