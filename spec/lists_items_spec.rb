require 'spec_helper'

describe Traktr::Lists::Items do
  context 'POST methods' do
    RSpec.configure do |config|
      config.order_groups_and_examples do |list|
        list.sort_by { |item| ["#add", "#delete"].index(item.description) }
      end
    end

    before :all do
      client = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      client.lists.add({:name => "rspec private", :privacy => "private"})
      @slug = "rspec-private"
      @movie = { :type => "movie", :imdb_id => "tt0372784" }
    end

    after :all do
      client = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      client.lists.delete(@slug)
    end

  	context 'with valid api_key and auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      end

  	  it '#add' do
  	  	expect( @trakt.lists.items.add(@slug, @movie).status ).to eql("success")
  	  end

      it '#delete' do
      	expect( @trakt.lists.items.delete(@slug, @movie).status ).to eql("success")
      end
    end
  	
  	context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

  	  it '#add' do
        expect{ @trakt.lists.items.add(@slug, @movie) }.to raise_error(Traktr::ResponseError)
  	  end

      it '#delete' do
        expect{ @trakt.lists.items.delete(@slug, @movie) }.to raise_error(Traktr::ResponseError)
      end
    end
  	
  	context 'without auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#add' do
        expect{ @trakt.lists.items.add(@slug, @movie) }.to raise_error(Traktr::ResponseError)
      end
      
      it '#delete' do
        expect{ @trakt.lists.items.delete(@slug, @movie) }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end