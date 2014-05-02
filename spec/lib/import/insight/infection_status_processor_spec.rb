require 'spec_helper'

describe Insight::InfectionStatusProcessor do
  let(:row_hash) { row_hashes.first }
  let(:visit) { FactoryGirl.create(:visit) }
  let(:infection_status_processor) { Insight::InfectionStatusProcessor.new(row_hash: row_hash, visit_id: visit.id) }

  describe 'class constants' do
    it { expect(Insight::InfectionStatusProcessor::INFECTION_TEST_MAP.length).to eq(Insight::InfectionStatusProcessor::INFECTION_RESULT_MAP.length) }

    describe 'INFECTION_TEST_MAP' do
      it { expect(Insight::InfectionStatusProcessor::INFECTION_TEST_MAP.class).to eq(Hash) }
    end

    describe 'INFECTION_RESULT_MAP' do
      it { expect(Insight::InfectionStatusProcessor::INFECTION_RESULT_MAP.class).to eq(Hash) }
    end
  end

  describe '#tested_for?' do
    context 'given a visit tested for Chlamydia' do
      it { expect(infection_status_processor.tested_for?('Chlamydia')).to eq(true) }
    end

    context 'given a visit not tested for HIV' do
      it { expect(infection_status_processor.tested_for?('HIV')).to eq(false) }
    end
  end

  describe '#positive_for?' do
    context 'given a visit positive for Chlamydia' do
      it { expect(infection_status_processor.positive_for?('Chlamydia')).to eq(true) }
    end

    context 'given a visit negative for Syphilis' do
      it { expect(infection_status_processor.positive_for?('Syphilis')).to eq(false) }
    end
  end

  describe '#boolify_value' do
    context 'given "1"' do
      it { expect(infection_status_processor.boolify_value('1')).to eq(true) }
    end

    context 'given "0"' do
      it { expect(infection_status_processor.boolify_value('0')).to eq(false) }
    end

    context 'given nil' do
      it { expect(infection_status_processor.boolify_value(nil)).to be_nil }
    end
  end

  describe '#process!' do
    context InfectionTest.model_name.human do
      it 'creates the proper records' do
        expect {
          infection_status_processor.process!
        }.to change(InfectionTest, :count).by(3)
      end
    end

    context Result.model_name.human do
      it 'creates the proper records' do
        expect {
          infection_status_processor.process!
        }.to change(Result, :count).by(3)
      end
    end
  end
end

