require 'spec_helper'

describe Traktr::Lists do
  context 'POST methods' do
    RSpec.configure do |config|
      config.order_groups_and_examples do |list|
        list.sort_by { |item| ['#add', '#update', '#delete'].index(item.description) }
      end
    end
    context 'with valid api_key and auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      end

      it '#add' do
        expect(@trakt.lists.add(name: 'rspec private', privacy: 'private').status).to eql('success')
      end

      it '#update' do
        expect(@trakt.lists.update('rspec-private',  name: 'rspec private 2').status).to eql('success')
      end

      it '#delete' do
        expect(@trakt.lists.delete('rspec-private-2').status).to eql('success')
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#add' do
        expect { @trakt.lists.add(name: 'rspec private', privacy: 'private') }.to raise_error(Traktr::ResponseError)
      end

      it '#update' do
        expect { @trakt.lists.update('rspec-private',  name: 'rspec private 2') }.to raise_error(Traktr::ResponseError)
      end

      it '#delete' do
        expect { @trakt.lists.delete('rspec-private-2') }.to raise_error(Traktr::ResponseError)
      end
    end

    context 'without auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#add' do
        expect { @trakt.lists.add(name: 'rspec private', privacy: 'private') }.to raise_error(Traktr::ResponseError)
      end

      it '#update' do
        expect { @trakt.lists.update('rspec-private',  name: 'rspec private 2') }.to raise_error(Traktr::ResponseError)
      end

      it '#delete' do
        expect { @trakt.lists.delete('rspec-private-2') }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end
