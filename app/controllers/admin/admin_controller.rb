class Admin::AdminController < ApplicationController
  before_action :logged_in_user

  def index
    render 'admin/admin/index'
  end

end
