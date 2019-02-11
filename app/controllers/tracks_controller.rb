class TracksController < ApplicationController
  def index
    page = params[:tracks][:page] || 1
    @tracks = Track.page(page).includes(:genres)
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end
end
