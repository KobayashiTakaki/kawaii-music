module SessionsHelper

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def logged_in_user
    unless logged_in?
      redirect_to root_url
    end
  end
end
