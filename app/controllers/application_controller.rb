class ApplicationController < ActionController::Base
  include ApplicationConcerns
  # before_action :log_out_due_to_inactivity
  before_action :set_current_user
  before_action :set_i18n_locale_from_params
  before_action :authorize
  before_action :update_counter
  around_action :set_response_time

  protected
    def set_response_time
      starting_time = Time.now
      yield
      time_taken = Time.now - starting_time
      response.headers["x-responded-in"] = time_taken
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] =
            "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end

    def set_current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def authorize
      unless  User.find_by(id: session[:user_id])
        redirect_to login_url, notice: "Please log in"
      end
    end

    def update_counter
      session[:hit_count] ||= {}
      session[:hit_count][request.path] ||= 0
      session[:hit_count][request.path] += 1
      @hit_count = session[:hit_count][request.path]
    end
end
