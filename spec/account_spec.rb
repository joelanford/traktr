require 'spec_helper'

describe Traktr::Account do
  context 'POST methods' do
    context 'with valid api_key and auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      end

      it '#create', :misbehaving => true do
        pending("Pending valid developer API key")
        expect( @trakt.account.create(CREATE_USER_NAME, CREATE_USER_PASS, CREATE_USER_EMAIL).status ).to eql('failure')
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

      it '#create' do
        expect { @trakt.account.create(CREATE_USER_NAME, CREATE_USER_PASS, CREATE_USER_EMAIL) }.to raise_error(Traktr::ResponseError)
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

      it '#create', :misbehaving => true do
        pending("Pending valid developer API key")
        expect( @trakt.account.create(CREATE_USER_NAME, CREATE_USER_PASS, CREATE_USER_EMAIL).status ).to eql('failure')
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
