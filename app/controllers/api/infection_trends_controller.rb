module Api
  # Handles infection trends API requests
  class InfectionTrendsController < ActionController::API
    def index
      if params[:from].present? && params[:to].present?
        infections = Infection.all

        trends = InfectionTrendSummarizer.new(:to => params[:to],
                                              :from => params[:from],
                                              :infections => infections).infection_trends
        render json: trends
      else
        head 400
      end
    end
  end
end
