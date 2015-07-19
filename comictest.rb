#comic_app_spec.rb

require './comic_app.rb'
require 'rspec'
require 'rack/test'
require 'spec_helper'

describe 'Comic App' do
  include Rack::Test::Methods
  
  def app
    ComicApp.new!
  end

  it "says Test" do
    get '/hi'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('Test')
  end
  
  it "get the first page url" do
    get '/fred'
    expect(last_response.location).to eq('http://example.org/fred/1')
  end
  
  it "contains first author" do
    get '/'
    expect(last_response.body).to include('John Biggers')
  end
  
  it 'should have authors directory' do
    expect(Dir.entries(app.settings.public_dir)).to include('authors')
  end
  
  describe 'author dir test' do
    before(:all) do
      Dir.mkdir(File.join(app.settings.public_dir, 'authors','biggers_john'))
      Dir.mkdir(File.join(app.settings.public_dir, 'authors','nemerovski_bathsheba'))
      testfile = File.open(File.join(app.settings.public_dir, 'authors' ,'testfile.txt'), 'w')
      testfile.close
      # app.set :authors, Proc.new { app.author_dir_load }
    end
    
    after(:all) do
      Dir.delete(File.join(app.settings.public_dir, 'authors','nemerovski_bathsheba'))
      Dir.delete(File.join(app.settings.public_dir, 'authors','biggers_john'))
      File.delete(File.join(app.settings.public_dir, 'authors' ,'testfile.txt'))
    end
    
    it ":author_dir_load" do
      expect(app.settings.authors).to include('biggers_john')
    end
    
    it ":author_dir_load ordered" do
      expect(app.settings.authors.first).to eq('biggers_john')
    end
    
    it ":author_dir_load no files" do
      expect(app.settings.authors).not_to include('testfile.txt')
    end
    
    it ":author_name" do
      expect(app.author_name(1)).to eq('Bathsheba Nemerovski')
    end
  end
  
end