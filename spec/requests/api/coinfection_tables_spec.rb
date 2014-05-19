require 'spec_helper'

describe Api::CoinfectionTablesController, :type => :request do
  let(:path) { '/api/coinfection_tables' }

  describe 'GET' do
    before(:each) { get path }

    it { expect(response.status).to eq(200) }

    it { expect(response.body).not_to eq('') }

    it { expect(Oj.load(response.body).keys.sort).to eq(Infection.pluck(:name).sort) }
  end
end
