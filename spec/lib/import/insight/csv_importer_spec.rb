require 'spec_helper'

describe Insight::CsvImporter do
  let(:path) { Rails.root.join('spec', 'data', 'test_import_data.csv').to_s }
  let(:stream) { File.open(path, 'rb') }
  let(:row_hash) { DataStreamImporter.new(stream: stream).to_hashes.first }

  after(:each) { stream.close }

  let(:csv_importer) { Insight::CsvImporter.new(stream: stream) }

  describe '#import!' do
    context 'new records' do
      {
        Patient => 88,
        Visit => 89
      }.each do |klass, num|
        it klass.model_name.human do
          expect {
            csv_importer.import!
          }.to change(klass, :count).by(num)
        end
      end
    end
  end
end
