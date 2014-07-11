require 'spec_helper'

describe Api::CallInsController, :type => :request do
  let(:visit) { FactoryGirl.create(:visit) }

  describe 'GET /api/call_ins/username.xml' do
    let(:path) { '/api/call_ins/username.xml' }

    before(:each) { get path }

    it { expect(response.status).to eq(200) }
    it { expect(response.body).not_to eq('') }
    it { expect(response.content_type).to eq(:xml) }
  end

  describe 'POST /api/call_ins/password.xml' do
    let(:path)  { '/api/call_ins/password.xml' }

    context 'with a valid visit user number' do
      before(:each) { post path, Digits: visit.phone_user_number }

      it { expect(response.status).to eql(200) }
      it { expect(response.body).not_to eq('') }
      it { expect(response.content_type).to eq(:xml) }
      it { expect(subject).to render_template("api/call_ins/password") }
    end

    context 'with an invalid visit user number' do
      before(:each) { post path, Digits: 99999999999 }

      it { expect(response.status).to eql(200) }
      it { expect(response.body).not_to eq('') }
      it { expect(response.content_type).to eq(:xml) }
      it { expect(subject).to render_template("api/call_ins/results") }
    end
  end

  describe 'POST /api/call_ins/:user_number/results.xml' do
    let(:path) { "/api/call_ins/#{visit.phone_user_number}/results.xml" }

    context 'with a valid visit password number' do
      before(:each) { post path, Digits: visit.phone_password_number }

      it { expect(response.status).to eql(200) }
      it { expect(response.body).not_to eq('') }
      it { expect(response.content_type).to eq(:xml) }
      # TODO: What do we see on valid cases?
      #it { expect(response.body).to include?("results") }
    end

    context 'with an invalid visit password number' do
      before(:each) { post path, Digits: 999999999 }

      it { expect(response.status).to eql(200) }
      it { expect(response.body).not_to eq('') }
      it { expect(response.content_type).to eq(:xml) }
      it { expect(response.body).to include("not valid") }
    end
  end

end
