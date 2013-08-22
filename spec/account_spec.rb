require 'spec_helper'

describe Traktr::Account do
  context 'POST methods' do
    context 'with valid api_key and auth credentials' do
      before :all do
        Traktr.api_key  = API_KEY
        Traktr.username = USERNAME
        Traktr.password = PASSWORD
      end

      after :all do
        Traktr.api_key  = ''
        Traktr.username = ''
        Traktr.password = ''
      end

      it '#settings' do
        expect(Traktr::Account.settings.status).to eql('success')
      end

      it '#test' do
        expect(Traktr::Account.test.status).to eql('success')
      end
    end

    context 'without valid api_key' do
      before :all do
        Traktr.username = USERNAME
        Traktr.password = PASSWORD
      end

      after :all do
        Traktr.username = ''
        Traktr.password = ''
      end

      it '#settings' do
        expect { comments = Traktr::Account.settings }.to raise_error(Traktr::ResponseError)
      end

      it '#test' do
        expect { summary = Traktr::Account.test }.to raise_error(Traktr::ResponseError)
      end
    end

    context 'without valid auth credentials' do
      before :all do
        Traktr.api_key = API_KEY
      end

      after :all do
        Traktr.api_key = ''
      end

      it '#settings' do
        expect { comments = Traktr::Account.settings }.to raise_error(Traktr::ResponseError)
      end

      it '#test' do
        expect { summary = Traktr::Account.test }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end