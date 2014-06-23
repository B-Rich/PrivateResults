class HomeController < ApplicationController
  def index
    @patients = Patient.count
    @results = Result.count
  end
end
