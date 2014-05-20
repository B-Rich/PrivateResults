require 'spec_helper'

describe InfectionTrendSummarizer do
  let(:infection) { Infection.first || FactoryGirl.create(:infection) }

  let(:visit) { FactoryGirl.create(:visit) }

  let(:infection_tests) { (1..5).to_a.map {|i| FactoryGirl.create(:infection_test,
                                                                  visit: visit,
                                                                  infection: infection) } }

  let(:results) { (1..5).to_a.map {|i| FactoryGirl.create(:result,
                                                          positive: (i % 2 == 0),
                                                          infection_test: infection_tests[i-1],
                                                          visit: visit,
                                                          infection: infection) } }

  let(:from_date) { 1.year.ago }
  let(:to_date) { 1.year.from_now }

  let(:infection_list) { Infection.all }
  let(:infection_trend_summarizer) { InfectionTrendSummarizer.new(from: from_date,
                                                                  to: to_date,
                                                                  infections: infection_list) }

  before(:each) { results }

  describe '#infection_trends' do
    let(:output) { infection_trend_summarizer.infection_trends }

    Infection.pluck(:name).each do |infection_name|
      context 'included infections' do
        it { expect(output.keys).to include(infection_name) }
      end
    end

    context 'infections' do
      context 'trend lengths' do
        it { expect(output[infection.name].length).to eq(53) }
        it { expect(output[infection.name].any?).to eq(true) }
      end
    end
  end
end
