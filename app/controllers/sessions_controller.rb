class SessionsController < ApplicationController
    def login

    end

    def logout
        session.delete(:user_id)
        @current_user = nil
    end
end
