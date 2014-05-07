require 'spec_helper'

describe HomeController do

  describe 'GET /' do
    it 'is a little teapot' do
      get('/')
      expect(response.code).to eq('418')
    end
  end

end
