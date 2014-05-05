require 'spec_helper'

describe Insight::CsvImporter do
  let(:stream) { double('io stream') }

  let(:csv_importer) { Insight::CsvImporter.new(stream: stream) }

  before(:each) do
    allow(csv_importer).to receive(:row_hashes).and_return(row_hashes)
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
