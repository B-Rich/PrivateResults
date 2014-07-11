require 'spec_helper'

feature "#{Patient.model_name.human} search" do
  before(:each) { visit providers_patients_path }

  let(:form_selector) { 'form#new_patient_search' }
  let(:search_input_name) { "#{Patient.model_name.human} ID" }

  given(:patient) { FactoryGirl.create(:patient) }
  given(:visits) { [FactoryGirl.create(:visit, patient: patient), FactoryGirl.create(:visit, patient: patient)] }

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
    before(:each) do
      visits
      fill_in(search_input_name, with: patient.patient_number)
      click_on("Search")
    end

    scenario 'searching for a patient' do
      within('.patient_search_result') do
        expect(page).to have_content(patient.patient_number)
      end
    end

    scenario 'displaying basic patient info' do
      within('.patient_search_result') do
        expect(page).to have_content("#{patient.visits.count} #{Visit.model_name.human.pluralize}")
        expect(page).to have_content(Patient.human_attribute_name(:created))
      end
    end

    scenario 'display visits' do
      within('.patient_search_result') do
        visits.each do |visit|
          expect(page).to have_css(".visit[data-visit-uuid='#{visit.uuid}']")
          expect(page).to have_css(".visit[data-visit-id='#{visit.id}']")
        end
      end
    end
  end

  context 'given a non-existant patient' do
    before(:each) do
      fill_in(search_input_name, with: patient.patient_number + '10')
      click_on("Search")
    end

    scenario 'searching for a patient' do
      within('.main') do
        expect(page).not_to have_css('.patient_search_result')
        expect(page).to have_content(patient.patient_number)
        expect(page).to have_content(I18n.t(:not_found))
      end
    end
  end
end
