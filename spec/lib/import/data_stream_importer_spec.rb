require 'spec_helper'

describe DataStreamImporter do
  let(:path) { Rails.root.join('spec', 'data', 'test_import_data.csv').to_s }
  let(:stream) { File.open(path, 'rb') }
  let(:data_stream_importer) { DataStreamImporter.new(stream: stream) }

  after(:each) { stream.close }

  describe '#header' do
    context 'length' do
      it do
        data_stream_importer.rows; expect(data_stream_importer.header.length).to eq(117)
      end
    end
  end

  describe '#to_hashes' do
    let(:output) { data_stream_importer.to_hashes }

    context 'length' do
      it { expect(output.length).to eq(89) }
    end
  end
end
