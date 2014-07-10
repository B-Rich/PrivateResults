require 'spec_helper'

describe Providers::PatientsController, type: :feature do
  describe 'INDEX' do
    before(:each) { visit providers_patients_path }

    it 'has the right header' do
      within('.main') do
        expect(page).to have_content('Patients')
      end
    end

    context 'the search box' do
      let(:form_selector) { 'form#new_patient_search' }

      it('appears')             { expect(page).to have_css(form_selector) }
      it('has a search button') { expect(page).to have_css("#{form_selector} button[type=submit]") }
      it('has a clear button')  { expect(page).to have_css("#{form_selector} button[type=reset]")}
    end
  end
end
