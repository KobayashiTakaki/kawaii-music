class TracksController < ApplicationController
  def index
    @tracks = Track.includes(:genres).all.limit(5)
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end
end
