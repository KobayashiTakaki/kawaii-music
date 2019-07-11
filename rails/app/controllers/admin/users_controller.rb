class Admin::UsersController < ApplicationController
  def edit
  end

  def update
    if current_user.update_attributes(strong_params)
      redirect_to admin_root_path
    else
      render 'admin/users/edit'
    end
  end

  private
  def strong_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
