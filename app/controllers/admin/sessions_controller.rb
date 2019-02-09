class Admin::SessionsController < ApplicationController
  def new
    render 'admin/sessions/new'
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to admin_index_path
    else
      redirect_to root_url
    end
  end

  def destroy
  end

  private
  def log_in(user)
    session[:user_id] = user.id
  end

end
