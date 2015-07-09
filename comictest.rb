#comic_app_spec.rb

require './comic_app.rb'
require 'rspec'
require 'rack/test'

describe 'Comic App' do
  include Rack::Test::Methods
  
  def app
    ComicApp.new
  end
  
  it "says Test" do
    get '/hi'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('Test')
  end
end