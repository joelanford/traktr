require 'spec_helper'

describe Traktr::Rate do
  context 'POST methods' do
    before :all do
      @episode = { tvdb_id: 213221, title: 'Portlandia', year: 2011, season: 1, episode: 1, rating: 9 }
      @movie = { imdb_id: 'tt0082971', title: 'Indiana Jones and the Raiders of the Lost Ark', year: 1981, rating: 9 }
      @show = { tvdb_id: 213221, title: 'Portlandia', year: 2011, rating: 9 }

      @episode_unrate = { tvdb_id: 213221, title: 'Portlandia', year: 2011, season: 1, episode: 1, rating: 0 }
      @movie_unrate = { imdb_id: 'tt0082971', title: 'Indiana Jones and the Raiders of the Lost Ark', year: 1981, rating: 0 }
      @show_unrate = { tvdb_id: 213221, title: 'Portlandia', year: 2011, rating: 0 }
    end
    context 'with valid api_key and auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      end

      it '#episode' do
        expect(@trakt.rate.episode(@episode).status).to eql('success')
        expect(@trakt.rate.episode(@episode_unrate).status).to eql('success')
      end

      it '#episodes' do
        expect(@trakt.rate.episodes([@episode]).status).to eql('success')
        expect(@trakt.rate.episodes([@episode_unrate]).status).to eql('success')
      end

      it '#movie' do
        expect(@trakt.rate.movie(@movie).status).to eql('success')
        expect(@trakt.rate.movie(@movie_unrate).status).to eql('success')
      end

      it '#movies' do
        expect(@trakt.rate.movies([@movie]).status).to eql('success')
        expect(@trakt.rate.movies([@movie_unrate]).status).to eql('success')
      end

      it '#show' do
        expect(@trakt.rate.show(@show).status).to eql('success')
        expect(@trakt.rate.show(@show_unrate).status).to eql('success')
      end

      it '#shows' do
        expect(@trakt.rate.shows([@show]).status).to eql('success')
        expect(@trakt.rate.shows([@show_unrate]).status).to eql('success')
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#episode' do
        expect { @trakt.rate.episode(@episode) }.to raise_error(Traktr::ResponseError)
      end

      it '#episodes' do
        expect { @trakt.rate.episodes([@episode]) }.to raise_error(Traktr::ResponseError)
      end

      it '#movie' do
        expect { @trakt.rate.movie(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#movies' do
        expect { @trakt.rate.movies([@movie]) }.to raise_error(Traktr::ResponseError)
      end

      it '#show' do
        expect { @trakt.rate.show(@show) }.to raise_error(Traktr::ResponseError)
      end

      it '#shows' do
        expect { @trakt.rate.shows([@show]) }.to raise_error(Traktr::ResponseError)
      end
    end

    context 'without auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#episode' do
        expect { @trakt.rate.episode(@episode) }.to raise_error(Traktr::ResponseError)
      end

      it '#episodes' do
        expect { @trakt.rate.episodes([@episode]) }.to raise_error(Traktr::ResponseError)
      end

      it '#movie' do
        expect { @trakt.rate.movie(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#movies' do
        expect { @trakt.rate.movies([@movie]) }.to raise_error(Traktr::ResponseError)
      end

      it '#show' do
        expect { @trakt.rate.show(@show) }.to raise_error(Traktr::ResponseError)
      end

      it '#shows' do
        expect { @trakt.rate.shows([@show]) }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end
