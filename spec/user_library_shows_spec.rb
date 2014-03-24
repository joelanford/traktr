require 'spec_helper'

describe Traktr::User::Library::Shows do
  context 'GET methods' do
    context 'with valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#all' do
        expect( @trakt.user.library.shows.all("traktr").size ).to be >= 0
      end

      it '#collection' do
        expect( @trakt.user.library.shows.collection("traktr").size ).to be >= 0
      end

      it '#watched' do
        expect( @trakt.user.library.shows.watched("traktr").size ).to be >= 0
      end
    end

    context 'with valid api_key and auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      end

      it '#all' do
        expect( @trakt.user.library.shows.all.size ).to be >= 0
      end

      it '#collection' do
        expect( @trakt.user.library.shows.collection.size ).to be >= 0
      end

      it '#watched' do
        expect( @trakt.user.library.shows.watched.size ).to be >= 0
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#all' do
        expect{ @trakt.user.library.shows.all("traktr").size }.to raise_error(Traktr::ResponseError)
      end

      it '#collection' do
        expect{ @trakt.user.library.shows.collection("traktr").size }.to raise_error(Traktr::ResponseError)
      end

      it '#watched' do
        expect{ @trakt.user.library.shows.watched("traktr").size }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end
