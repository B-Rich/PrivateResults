require 'spec_helper'

describe Insight::CsvImporter do
  before(:all) do
    @stream = StringIO.new(File.read(Rails.root.join('spec', 'data', 'test_import_data.csv').to_s))
    @row_hashes = DataStreamImporter.new(stream: @stream).to_hashes
  end

  let(:stream) { @stream }

  after(:each) { stream.rewind }

  let(:csv_importer) { Insight::CsvImporter.new(stream: stream) }

  before(:each) do
    csv_importer.stub(:row_hashes => @row_hashes)
  end

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
