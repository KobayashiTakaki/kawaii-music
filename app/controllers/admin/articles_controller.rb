class Admin::ArticlesController < ApplicationController
  before_action :logged_in_user

  def index
    @articles = ['foo', 'bar']
  end

end
