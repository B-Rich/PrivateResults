require 'spec_helper'

describe InfectionActivitySummarizer do
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
  let(:infection_activity_summarizer) { InfectionActivitySummarizer.new(infection: infection,
                                                                        from: from_date,
                                                                        to: to_date) }

  before(:each) { results }

  describe '#as_json' do
    subject { infection_activity_summarizer.as_json }
    it { expect(Visit.count).to eq(1) }
    it { expect(Result.count).to eq(5) }
    it do
      should eq({
        :infection => infection.name,
        :data      => [infection_activity_summarizer.infection_activity_hash_for_date(visit.visited_on)]
      })
    end
  end

  describe '#results' do
    it { expect(infection_activity_summarizer.results.pluck(:id).sort).to eq(results.map(&:id).sort) }
  end

  describe '#results_for_date' do
    it { expect(infection_activity_summarizer.results_for_date(visit.visited_on).count).to eq(5) }
  end

  describe '#visits' do
    it { expect(infection_activity_summarizer.visits.count).to eq(1) }
    it { expect(infection_activity_summarizer.visits.first.id).to eq(visit.id) }
  end

  describe '#result_breakdown_hash_for_date' do
    let(:date) { visit.visited_on }
    subject { infection_activity_summarizer.result_breakdown_hash_for_date(date) }

    it do
      should == {
        :total    => 5,
        :positive => 2,
        :negative => 3
      }
    end
  end

  describe '#infection_tests' do
    let(:date) { visit.visited_on }

    it { expect(infection_activity_summarizer.infection_tests.count).to eq(5)}
  end

  describe '#infection_tests_for_date' do
    let(:date) { visit.visited_on }
    it { expect(infection_activity_summarizer.infection_tests_for_date(date).count).to eq(5)}
  end

  describe '#infection_activity_hash_for_date' do
    let(:date) { visit.visited_on }
    let(:output) { infection_activity_summarizer.infection_activity_hash_for_date(date) }
    subject { output }

    it do
      should == {
        :date    => date,
        :total   => infection_tests.count,
        :results => infection_activity_summarizer.result_breakdown_hash_for_date(date)
      }
    end

    context 'json schema' do
      it 'validates' do
        expect {
          JSON::Validator.validate!(InfectionActivitySummarizer::JSON_SCHEMA, output)
        }.not_to raise_error
      end
    end
  end
end
