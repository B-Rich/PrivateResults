module Api
  # Handles coinfection table API requests
  class CoinfectionTablesController < ActionController::API
    def index
      render json: CoinfectionSummarizer.coinfection_table
    end
  end
end
