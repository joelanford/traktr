require 'spec_helper'

describe Traktr::Server do
  context 'GET methods' do
    context 'with valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#time' do
        expect(@trakt.server.time).to be
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#movies' do
        expect { @trakt.server.time }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end
