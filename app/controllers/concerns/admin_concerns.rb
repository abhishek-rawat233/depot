module AdminConcerns
  def is_user_admin?
    @current_user.role == 'admin'
  end
end
