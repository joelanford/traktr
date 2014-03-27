require 'spec_helper'

describe Traktr::Network do
  context 'POST methods' do
  	context 'with valid api_key and auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
        @trakt2 = Traktr::Client.new(API_KEY_2, USERNAME_2, PASSWORD_2)
      end

      it '#approve' do
        @trakt.network.follow( USERNAME_2 )
        expect( @trakt2.network.approve( USERNAME ).status ).to eql("success")
        expect( @trakt.network.unfollow( USERNAME_2 ).status ).to eql("success")
      end

      it '#deny' do
        expect( @trakt.network.follow( USERNAME_2 ).status ).to eql("success")
        expect( @trakt2.network.deny( USERNAME ).status ).to eql("success")
      end

  	  it '#follow' do
  	  	expect( @trakt.network.follow( USERNAME_2 ).status ).to eql("success")
        expect( @trakt2.network.deny( USERNAME ).status ).to eql("success")
 	    end

      it '#requests' do
        @trakt.network.follow( USERNAME_2 )        
        requests = @trakt2.network.requests
        expect( requests.size ).to eql(1)
        expect( requests[0].username ).to eql( USERNAME )
        expect( @trakt.network.unfollow( USERNAME_2 ).status ).to eql("success")        
      end

      it '#unfollow' do
        expect( @trakt.network.follow( USERNAME_2 ).status ).to eql("success")
        expect( @trakt2.network.approve( USERNAME ).status ).to eql("success")
        expect( @trakt.network.unfollow( USERNAME_2 ).status ).to eql("success")
      end
    end
  	
  	context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#approve' do
        expect{ @trakt.network.approve( USERNAME_2 ) }.to raise_error(Traktr::ResponseError)
      end

      it '#deny' do
        expect{ @trakt.network.deny( USERNAME_2 ) }.to raise_error(Traktr::ResponseError)
      end

      it '#follow' do
        expect{ @trakt.network.follow( USERNAME_2 ) }.to raise_error(Traktr::ResponseError)
      end

      it '#requests' do
        expect{ @trakt.network.requests }.to raise_error(Traktr::ResponseError)
      end

      it '#unfollow' do
        expect{ @trakt.network.unfollow( USERNAME_2 ) }.to raise_error(Traktr::ResponseError)
      end
    end
  	
  	context 'without auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#approve' do
        expect{ @trakt.network.approve( USERNAME_2 ) }.to raise_error(Traktr::ResponseError)
      end

      it '#deny' do
        expect{ @trakt.network.deny( USERNAME_2 ) }.to raise_error(Traktr::ResponseError)
      end

      it '#follow' do
        expect{ @trakt.network.follow( USERNAME_2 ) }.to raise_error(Traktr::ResponseError)
      end

      it '#requests' do
        expect{ @trakt.network.requests }.to raise_error(Traktr::ResponseError)
      end

      it '#unfollow' do
        expect{ @trakt.network.unfollow( USERNAME_2 ) }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end