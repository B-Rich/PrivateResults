module Api
  # Handles Patient test result call in requests
  class CallInsController < ActionController::API
    before_filter :force_xml

    def username
      render "api/call_ins/username"
    end

    def password
      visit = Visit.find_by_phone_user_number params[:Digits]

      unless visit.nil?
        @user_number = params[:Digits]
        render "api/call_ins/password" and return
      end

      @message = "No patient visit found by the number #{params[:Digits].chars.join(',')}. Please try your call again. Goodbye!"
      render "api/call_ins/results"
    end

    def results
      visit = Visit.find_by_phone_user_number_and_phone_password_number params[:user_number], params[:Digits]

      unless visit.nil?
        # TODO: Add logic to determine results for visit and set for @message
      else
        @message = "The username and password combination you entered was not valid. Please try your call again. Goodbye!"
      end

      render "api/call_ins/results"
    end

    def force_xml
      request.format = :xml
    end
  end
end
