require 'spec_helper'

describe Traktr::Lists do
  context 'POST methods' do
  	context 'with valid api_key and auth credentials' do
  	  it '#add' do
  	  	expect(false).to eql(true)
  	  end
      it '#delete' do
      	expect(false).to eql(true)
      end
  	  it '#update' do
  	  	expect(false).to eql(true)
  	  end
    end
  	
  	context 'without valid api_key' do
  	  it '#add' do
  	  	expect(false).to eql(true)
  	  end
      it '#delete' do
      	expect(false).to eql(true)
      end
  	  it '#update' do
  	  	expect(false).to eql(true)
  	  end
    end
  	
  	context 'without auth credentials' do
  	  it '#add' do
  	  	expect(false).to eql(true)
  	  end
      it '#delete' do
      	expect(false).to eql(true)
      end
  	  it '#update' do
  	  	expect(false).to eql(true)
  	  end
    end
  end
end