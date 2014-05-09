require 'spec_helper'

describe HomeController do

  describe 'GET /' do
    it 'Gives the dashboard' do
      get('/')
      expect(response.status).to eq(200)
    end
  end

end
