require 'spec_helper'

describe Traktr::User::Progress do
  context 'GET methods' do
    context 'with valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#collected' do
        expect( @trakt.user.progress.collected("traktr").size ).to be >= 0
      end

      it '#watched' do
        expect( @trakt.user.progress.watched("traktr").size ).to be >= 0
      end
    end

    context 'with valid api_key and auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      end

      it '#collected' do
        expect( @trakt.user.progress.collected.size ).to be >= 0
      end

      it '#watched' do
        expect( @trakt.user.progress.watched.size ).to be >= 0
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#collected' do
        expect{ @trakt.user.progress.collected("traktr").size }.to raise_error(Traktr::ResponseError)
      end

      it '#watched' do
        expect{ @trakt.user.progress.watched("traktr").size }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end
