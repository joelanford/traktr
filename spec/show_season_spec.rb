require 'spec_helper'

describe Traktr::Show::Season do
  context 'POST methods' do
    before :all do
      trakt = Traktr::Client.new(API_KEY)
      @show = trakt.show.summary('dexter')
      @season = 1
    end

    context 'with valid api_key and auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      end

      it '#library' do
        expect( @trakt.show.season.library(@show, @season).status ).to eql('success')
      end

      it '#seen' do
        expect( @trakt.show.season.seen(@show, @season).status ).to eql('success')
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#library' do
        expect { @trakt.show.season.library(@show, @season) }.to raise_error(Traktr::ResponseError)
      end

      it '#seen' do
        expect { @trakt.show.season.seen(@show, @season) }.to raise_error(Traktr::ResponseError)
      end
    end

    context 'without valid auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#library' do
        expect { @trakt.show.season.library(@show, @season) }.to raise_error(Traktr::ResponseError)
      end

      it '#seen' do
        expect { @trakt.show.season.seen(@show, @season) }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end