require 'spec_helper'

describe Insight::RowHandler do
  let(:row_hash) { row_hashes.first }

  let(:row_handler) { Insight::RowHandler.new(row_hash: row_hash) }

  describe '#run!' do
    [Patient, Visit].each do |klass|
      context klass.model_name.human do
        it "creates a new record" do
          expect {
            row_handler.run!
          }.to change(klass, :count).by(1)
        end
      end
    end

    describe InfectionTest.model_name.human do
      it 'creates new records' do
        expect {
          row_handler.run!
        }.to change(InfectionTest, :count).by(3)
      end
    end
  end

  describe '#map_keys' do
    let(:input_hash) do
      {
        :panda => 'bamboo',
        :curry => 'noodle'
      }
    end

    let(:transform_hash) do
      input_hash.map {|key, val| {key => val.to_sym} }.reduce(&:merge)
    end

    context 'given existing keys' do
      subject { row_handler.map_keys(input_hash, transform_hash) }
      it { should == {:bamboo => 'bamboo', noodle: 'noodle'} }
    end

    context 'given a non-existant key' do
      it 'pukes' do
        expect {
          row_handler.map_keys(input_hash, transform_hash.merge(:missing => 'key'))
        }.to raise_error(KeyError)
      end
    end
  end
end
