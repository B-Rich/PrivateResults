module Providers
  class PatientsController < ApplicationController
    def index
      @patient_search = PatientSearch.new
    end
  end
end
