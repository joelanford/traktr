require 'spec_helper'

describe Traktr::Comment do
  context 'POST methods' do
    before :all do
      @episode_data = { :title => "Dexter", :year => "2006", :season => "1", :episode => "1", :comment => "Test comment - #{Time.now.to_s}" }
      @movie_data   = { :title => "The Dark Knight Rises", :year => "2012", :comment => "Test comment - #{Time.now.to_s}" }
      @show_data    = { :title => "Dexter", :year => "2006", :comment => "Test comment - #{Time.now.to_s}" }
    end

    context 'with valid api_key and auth credentials', :misbehaving => true do
      before :all do
        @trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      end

      it '#episode' do
        expect( @trakt.comment.episode(@episode_data).status ).to eql('success')
      end

      it '#movie' do
        expect( @trakt.comment.movie(@movie_data).status ).to eql('success')
      end

      it '#show' do
        expect( @trakt.comment.show(@show_data).status ).to eql('success')
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil, USERNAME, PASSWORD)
      end

      it '#episode' do
        expect { @trakt.comment.episode(@episode_data) }.to raise_error(Traktr::ResponseError)
      end

      it '#movie' do
        expect { @trakt.comment.movie(@movie_data) }.to raise_error(Traktr::ResponseError)
      end

      it '#show' do
        expect { @trakt.comment.show(@show_data) }.to raise_error(Traktr::ResponseError)
      end
    end

    context 'without valid auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#episode' do
        expect { @trakt.comment.episode(@episode_data) }.to raise_error(Traktr::ResponseError)
      end

      it '#movie' do
        expect { @trakt.comment.movie(@movie_data) }.to raise_error(Traktr::ResponseError)
      end

      it '#show' do
        expect { @trakt.comment.show(@show_data) }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end
