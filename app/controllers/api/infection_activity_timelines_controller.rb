# Aggregate data API
module Api
  # Timelines for infection activities
  class InfectionActivityTimelinesController < ActionController::API
    # GET method
    # @api private
    def index
      if params[:from].present? && params[:to].present? && params[:infection].present?
        summary = Infection.where(name: params[:infection]).map do |infection|
          InfectionActivitySummarizer.new(:infection => infection,
                                          :from      => Date.parse(params[:from]),
                                          :to        => Date.parse(params[:to]))
        end.first

        render json: summary
      else
        head 400
      end
    end
  end
end
