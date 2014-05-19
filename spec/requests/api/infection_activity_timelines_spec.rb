require 'spec_helper'

describe Api::InfectionActivityTimelinesController, type: :request do
  let(:path) { '/api/infection_activity_timelines' }
  describe 'GET' do
    context 'given invalid parameters' do
      it 'returns 400' do
        get path
        expect(response.code).to eq('400')
      end
    end

    context 'given valid parameters' do

      let(:params) do
        {
          :from => 1.year.ago,
          :to   => Date.today,
          :infection => (Infection.first.name || FactoryGirl.create(:infection).name)
        }
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
end
