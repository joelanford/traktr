require 'spec_helper'

describe Traktr::User::Network do
  context 'GET methods' do
    context 'with valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#followers' do
        expect(@trakt.user.network.followers('traktr').size).to be >= 0
      end

      it '#following' do
        expect(@trakt.user.network.following('traktr').size).to be >= 0
      end

      it '#friends' do
        expect(@trakt.user.network.friends('traktr').size).to be >= 0
      end
    end

    context 'with valid api_key and auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      end

      it '#followers' do
        expect(@trakt.user.network.followers.size).to be >= 0
      end

      it '#following' do
        expect(@trakt.user.network.following.size).to be >= 0
      end

      it '#friends' do
        expect(@trakt.user.network.friends.size).to be >= 0
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#followers' do
        expect { @trakt.user.network.followers('traktr').size }.to raise_error(Traktr::ResponseError)
      end

      it '#following' do
        expect { @trakt.user.network.following('traktr').size }.to raise_error(Traktr::ResponseError)
      end

      it '#friends' do
        expect { @trakt.user.network.friends('traktr').size }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end
