module Providers
  class PatientsController < ApplicationController
    def index
      if params[:patient_number].present?
        @patient_search = PatientSearch.new(patient_number: patient_search_params[:patient_number])

        @patients = @patient_search.patients
      else
        @patient_search = PatientSearch.new
      end
    end

    private
    def patient_search_params
      params.require(:patient_number).permit(:patient_number)
    end
  end
end
