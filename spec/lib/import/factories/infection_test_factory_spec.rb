require 'spec_helper'

describe InfectionTestFactory do
  let(:visit) { FactoryGirl.create(:visit) }
  let(:infection) { Infection.first || FactoryGirl.create(:infection) }

  let(:infection_test_attributes) do
    {
      :name         => "Infection Test 123",
      :visit_id     => visit.id,
      :infection_id => infection.id
    }
  end

  let(:infection_test_factory) { InfectionTestFactory.new(infection_test_attributes) }

  describe '#make!' do
    context 'given an existing infection_test' do
      before(:each) { InfectionTestFactory.new(infection_test_attributes).make! }

      it 'does not create a new record' do
        expect {
          InfectionTestFactory.new(infection_test_attributes).make!
        }.to change(InfectionTest, :count).by(0)
      end

      it 'returns the corresponding record' do
        model_from_db = InfectionTestFactory.new(infection_test_attributes).make!
        expect(model_from_db).to eq(InfectionTest.last)
      end
    end

    context 'given a new infection_test' do
      it 'creates a new record' do
        expect {
           InfectionTestFactory.new(infection_test_attributes).make!
        }.to change(InfectionTest, :count).by(1)
      end
    end

  end
end
