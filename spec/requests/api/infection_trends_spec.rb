require 'spec_helper'

describe Api::InfectionTrendsController, type: :request do
  let(:path) { '/api/infection_trends' }

  let(:params) do
    {
      :from => 2.years.ago,
      :to => 1.year.ago
    }
  end

  describe 'GET' do
    context 'given invalid parameters' do
      it 'returns 400' do
        get path
        expect(response.code).to eq('400')
      end
    end

    before(:each) do
      get path, params
    end

    it 'returns 200' do
      expect(response.code).to eq('200')
    end

    it do
      expect(response.body).not_to eq('')
    end
  end
end
