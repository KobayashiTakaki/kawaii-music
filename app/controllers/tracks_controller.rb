class TracksController < ApplicationController
  def index
    @page = params[:tracks][:page] || 1
    if params[:tracks][:model]
      if params[:tracks][:model] == 'genre'
        genre_id = valid_id(params[:tracks][:model_id])
        @tracks = Track.by_genre_id(genre_id)
                      .include_genres
                      .order_random
                      .page(@page)
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

  private
  def valid_id(text)
    return '' unless text.match(/\A[0-9]*\z/)
    text
  end
end
