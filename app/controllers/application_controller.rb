class ApplicationController < ActionController::Base
  before_action :set_i18n_locale_from_params
  before_action :authorize
  before_action :set_current_user, :update_counter
  around_action :action_view_response_time
  before_action :log_out_due_to_inactivity

  before_action :check_browser

  protected
    def check_browser
      user_agent = request.user_agent
      if user_agent.match? /.*firefox.*/i and request.path != store_index_path
        render file: "#{Rails.root}/public/404", status: :not_found
      end
    end

    def log_out_due_to_inactivity
      session[:inactive_time] ||= Time.now
      if @current_user.present?
        if Time.now - session[:inactive_time] > 5.minutes
          reset_session
          redirect_to login_path, notice: "Logged out because of inactivity!!!!"
        else
          session[:inactive_time] = Time.now
        end
      end
    end

    def action_view_response_time
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
      hit_counter = HitCounter.first
      hit_counter = HitCounter.create unless hit_counter.present?
      hit_counter.increment(:hit_count, 1).save
      @hit_count = hit_counter.hit_count
    end
end
