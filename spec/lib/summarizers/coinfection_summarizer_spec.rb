require 'spec_helper'

describe CoinfectionSummarizer do
  let(:infection) { Infection.first || FactoryGirl.create(:infection) }
  let(:visit) { FactoryGirl.create(:visit) }
  let(:infection_test) { FactoryGirl.create(:infection_test, visit: visit) }
  let(:result) { FactoryGirl.create(:result, infection_test: infection_test, visit: visit, infection: infection) }

  let(:coinfection_summarizer) { CoinfectionSummarizer.new(infection: infection) }

  describe '#coinfection_hash' do
    let(:output) { coinfection_summarizer.coinfection_hash }
    subject { output }

    it { expect(output.keys.sort).to eq(Infection.pluck(:name).sort) }
  end

  describe '.coinfection_table' do
    let(:output) { CoinfectionSummarizer.coinfection_table }

    it { expect(output.keys.sort).to eq(Infection.pluck(:name).sort) }

    Infection.all.each do |infection|
      it { expect(output[infection.name]).to eq(CoinfectionSummarizer.new(infection: infection).coinfection_hash) }
    end
  end
end
