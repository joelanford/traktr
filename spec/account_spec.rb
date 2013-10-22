require 'spec_helper'

describe Traktr::Account do
  context 'POST methods' do
    context 'with valid api_key and auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      end

      it '#settings' do
        expect( @trakt.account.settings.status ).to eql('success')
      end

      it '#test' do
        expect( @trakt.account.test.status ).to eql('success')
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil, USERNAME, PASSWORD)
      end

      it '#settings' do
        expect { @trakt.account.settings }.to raise_error(Traktr::ResponseError)
      end

      it '#test' do
        expect { @trakt.account.test }.to raise_error(Traktr::ResponseError)
      end
    end

    context 'without valid auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#settings' do
        expect { @trakt.account.settings }.to raise_error(Traktr::ResponseError)
      end

      it '#test' do
        expect { @trakt.account.test }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end