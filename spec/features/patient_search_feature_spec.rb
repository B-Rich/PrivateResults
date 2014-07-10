require 'spec_helper'

feature "#{Patient.model_name.human} search" do
  before(:each) { visit providers_patients_path }

  let(:form_selector) { 'form#new_patient_search' }
  let(:search_input_name) { "#{Patient.model_name.human} ID" }

  given(:patient) { FactoryGirl.create(:patient) }

  scenario 'loads the search page' do
    within('.main') do
      expect(page).to have_css('h1.page-header')
    end

    within('.main h1.page-header') do
      expect(page).to have_content(Patient.model_name.human.pluralize)
    end
  end

  scenario 'views the search form' do
    expect(page).to have_css(form_selector)
    expect(page).to have_css("#{form_selector} button[type=submit]")
    expect(page).to have_css("#{form_selector} button[type=reset]")
  end

  scenario 'user clicks the reset button', :js => true do
    fill_in(search_input_name, with: "1234")
    find('button[type=reset]').click
    expect(find_field(search_input_name).value).to eq('')
  end

  context 'given an existing patient' do
    scenario 'searching for a patient' do
      fill_in(search_input_name, with: patient.patient_number)
      click_on("Search")

      within('.main') do
        expect(page).to have_content(patient.patient_number)
      end
    end
  end

  context 'given a non-existant patient' do
    scenario 'searching for a patient' do
      fill_in(search_input_name, with: patient.patient_number + '10')
      click_on("Search")

      within('.main') do
        expect(page).not_to have_content(patient.patient_number)
        expect(page).to have_content(I18n.t(:not_found))
      end
    end
  end
end
