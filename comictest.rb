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

  it 'should have authors directory' do
    expect(Dir.entries(app.settings.root)).to include('authors')
  end

  describe 'author dir test' do
    before(:all) do
      Dir.mkdir(File.join('authors','biggers_john'))
      Dir.mkdir(File.join('authors','nemerovski_bathsheba'))
      Dir.mkdir(File.join('authors', 'joyce_sarah-wells_frederick'))
      testfile = File.open(File.join('authors' ,'testfile.txt'), 'w')
      testfile.close
      # app.set :authors, Proc.new { app.author_dir_load }
    end

    after(:all) do
      Dir.delete(File.join('authors','nemerovski_bathsheba'))
      Dir.delete(File.join('authors','biggers_john'))
      Dir.delete(File.join('authors', 'joyce_sarah-wells_neil'))
      File.delete(File.join('authors' ,'testfile.txt'))
    end

    it "should not be empty" do
      expect(app.settings.authors).not_to be_empty
    end

    it ":author_dir_load" do
      expect(app.settings.authors.grep(/joyce_sarah/)).to_not be_empty
    end

    it ":author_dir_load no files" do
      expect(app.settings.authors).not_to include('testfile.txt')
    end

    it "has an author Hash" do
      expect(app.settings.author_list.has_key?("Sarah Joyce")).to be true
    end

    it "returns full author name as value" do
      expect(app.settings.author_list["Sarah Joyce"]).to eq("joyce_sarah-wells_neil")
    end
  end

end
