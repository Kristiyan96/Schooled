module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    session[:type] = user.class.to_s
  end

  def authenticated
    @authenticated ||= authenticated_type.find_by(id: session[:user_id])
  end

  def authenticated_type
    if params[:type]
      params[:type].constantize
    else
      raise 'No session'
    end
  end

  def logged_in?
    !authenticated.nil?
  end
end
