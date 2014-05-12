require 'spec_helper'

describe ResultFactory do
  let(:infection_test) { FactoryGirl.create(:infection_test) }
  let(:infection) { FactoryGirl.create(:infection) }
  let(:visit) { FactoryGirl.create(:visit) }

  let(:result_attributes) do
    {
      :name => "Result 123",
      :infection_test_id => infection_test.id,
      :positive => true,
      :infection_id => infection.id,
      :visit_id => visit.id
    }
  end

  let(:result_factory) { ResultFactory.new(result_attributes) }
  describe '#make!' do
    context 'given an existing result' do
      before(:each) { ResultFactory.new(result_attributes).make! }

      it 'does not create a new record' do
        expect {
          ResultFactory.new(result_attributes).make!
        }.to change(Result, :count).by(0)
      end

      it 'returns the corresponding record' do
        model_from_db = ResultFactory.new(result_attributes).make!
        expect(model_from_db).to eq(Result.last)
      end
    end

    context 'given a new result' do
      it 'creates a new record' do
        expect {
          ResultFactory.new(result_attributes).make!
        }.to change(Result, :count).by(1)
      end
    end
  end
end
