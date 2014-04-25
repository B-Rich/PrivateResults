require 'spec_helper'

describe Insight::RowHandler do
  let(:path) { Rails.root.join('spec', 'data', 'test_import_data.csv').to_s }
  let(:stream) { File.open(path, 'rb') }
  let(:row_hash) { DataStreamImporter.new(stream: stream).to_hashes.first }

  after(:each) { stream.close }

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
