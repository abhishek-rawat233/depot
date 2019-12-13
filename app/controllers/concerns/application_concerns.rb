module ApplicationConcerns
  def log_out_due_to_inactivity
    session[:inactive_time] ||= Time.now
    if @current_user.present?
      if Time.now - Time.new(session[:inactive_time]) > 5.minutes
        reset_session
        redirect_to login_path, notice: "Logged out because of inactivity!!!!"
      else
        session[:inactive_time] = Time.now
      end
    end
  end
end
