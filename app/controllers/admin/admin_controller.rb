class Admin::AdminController < ApplicationController
  def index
    unless logged_in?
      redirect_to root_url
    else
      render 'admin/admin/index'
    end
  end


  private
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

end
