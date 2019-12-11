class ApplicationController < ActionController::Base
  before_action :set_i18n_locale_from_params
  before_action :authorize
  before_action :set_current_user, :update_counter
  around_action :req

  protected
    def req
      debugger
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
