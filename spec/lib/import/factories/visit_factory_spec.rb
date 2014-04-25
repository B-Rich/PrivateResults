require 'spec_helper'

describe VisitFactory do
  let(:patient) { FactoryGirl.create(:patient) }

  let(:visit_attributes) do
    {
      :age                              => '42',
      :cosite                           => "D",
      :partners_last_6_months_5_or_more => "0",
      :race                             => "White",
      :sex                              => "M",
      :sexualidentity                   => "Straight",
      :sexualpref                       => "Opposite sex",
      :visit_date                       => "17-Nov-11",
      :zip_code                         => "21206"
    }
  end

  let(:visit_factory) { VisitFactory.new(visit_attributes) }

  describe '#parsed_visit_date' do
    let(:date_string) { visit_attributes[:visit_date] }
    subject { visit_factory.parsed_visit_date(date_string) }

    it { should eq(Date.new(2011, 11, 17)) }
  end

  describe '#parsed_age' do
    let(:age_string) { '42' }
    subject { visit_factory.parsed_age(age_string) }

    it { should eq(42) }
  end

  describe '#make!' do
    context 'given an existing visit' do
      before(:each) { VisitFactory.new(visit_attributes).make! }

      it 'does not create a new record' do
        expect {
          VisitFactory.new(visit_attributes).make!
        }.to change(Visit, :count).by(0)
      end

      it 'returns the corresponding record' do
        model_from_db = VisitFactory.new(visit_attributes).make!
        expect(model_from_db).to eq(Visit.last)
      end
    end

    context 'given a new visit' do
      it 'creates a new record' do
        expect {
           VisitFactory.new(visit_attributes).make!
        }.to change(Visit, :count).by(1)
      end
    end
  end

end
