class TracksController < ApplicationController
  def index
    @page = params[:tracks][:page] || 1
    if params[:tracks][:model]
      if params[:tracks][:model] == 'genre'
        @tracks = Genre.find(params[:tracks][:model_id])
          .tracks.page(@page).includes(:genres)
      end
    else
      @tracks = Track.random(30).page(@page).includes(:genres)
    end

    @total_pages = @tracks.total_pages

    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end
end
