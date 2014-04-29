require 'spec_helper'

describe Traktr::User do
  before :all do
    client = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
    client.lists.add('name' => 'rspec public', 'privacy' => 'public')
    client.lists.add('name' => 'rspec private', 'privacy' => 'private')
  end

  after :all do
    client = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
    client.lists.delete('rspec-public')
    client.lists.delete('rspec-private')
  end

  context 'GET methods' do
    context 'with valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#lastactivity' do
        la = @trakt.user.lastactivity(USERNAME)
        expect(la.keys.sort).to eql(%w(all episode movie show))
      end

      it '#list' do
        expect(@trakt.user.list('rspec-public', USERNAME).slug).to eql('rspec-public')
        expect(@trakt.user.list('rspec-private', USERNAME).status).to eql('failure')
      end

      it '#lists' do
        lists = @trakt.user.lists(USERNAME)
        expect(lists.length).to eql(1)
        expect(lists[0].slug).to eql('rspec-public')
      end

      it '#profile' do
        profile = @trakt.user.profile(USERNAME)
        expect(profile.keys.sort).to eql(
          %w(username protected full_name gender age location about joined avatar url vip stats watched watching).sort
        )
      end

      it '#watching' do
        watching = @trakt.user.watching(USERNAME)
        expect(watching.size).to eql(0)
      end
    end

    context 'with valid api_key and auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      end

      it '#lastactivity' do
        la = @trakt.user.lastactivity
        expect(la.keys.sort).to eql(%w(all episode movie show))
      end

      it '#list' do
        expect(@trakt.user.list('rspec-public').slug).to eql('rspec-public')
        expect(@trakt.user.list('rspec-private').slug).to eql('rspec-private')
      end

      it '#lists' do
        lists = @trakt.user.lists
        expect(lists.length).to eql(2)
        expect(lists[0].slug).to eql('rspec-public')
        expect(lists[1].slug).to eql('rspec-private')
      end

      it '#profile' do
        profile = @trakt.user.profile
        expect(profile.keys.sort).to eql(
          %w(username protected full_name gender age location about joined avatar url vip stats watched watching).sort
        )
      end

      it '#watching' do
        watching = @trakt.user.watching
        expect(watching.size).to eql(0)
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#lastactivity' do
        expect { @trakt.user.lastactivity(USERNAME) }.to raise_error(Traktr::ResponseError)
      end

      it '#list' do
        expect { @trakt.user.list('rspec-public', USERNAME) }.to raise_error(Traktr::ResponseError)
        expect { @trakt.user.list('rspec-private', USERNAME) }.to raise_error(Traktr::ResponseError)
      end

      it '#lists' do
        expect { @trakt.user.lists(USERNAME) }.to raise_error(Traktr::ResponseError)
      end

      it '#profile' do
        expect { @trakt.user.profile(USERNAME) }.to raise_error(Traktr::ResponseError)
      end

      it '#watching' do
        expect { @trakt.user.watching(USERNAME) }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end
