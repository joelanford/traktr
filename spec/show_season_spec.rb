require 'spec_helper'

describe Traktr::Show::Season do
  context 'POST methods' do
    before :all do
      Traktr.api_key  = API_KEY
      @show = Traktr::Show.summary('dexter')
      @season = 1
      Traktr.api_key  = ''
    end

    after :all do
      @show = nil
      @season = nil
    end

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

      it '#library' do
        expect(Traktr::Show::Season.library(@show, @season).status).to eql('success')
      end

      it '#seen' do
        expect(Traktr::Show::Season.seen(@show, @season).status).to eql('success')
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

      it '#library' do
        expect { comments = Traktr::Show::Season.library(@show, @season) }.to raise_error(Traktr::ResponseError)
      end

      it '#seen' do
        expect { summary = Traktr::Show::Season.seen(@show, @season) }.to raise_error(Traktr::ResponseError)
      end
    end

    context 'without valid auth credentials' do
      before :all do
        Traktr.api_key = API_KEY
      end

      after :all do
        Traktr.api_key = ''
      end

      it '#library' do
        expect { comments = Traktr::Show::Season.library(@show, @season) }.to raise_error(Traktr::ResponseError)
      end

      it '#seen' do
        expect { summary = Traktr::Show::Season.seen(@show, @season) }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end