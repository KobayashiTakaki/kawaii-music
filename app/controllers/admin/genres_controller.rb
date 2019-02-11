class Admin::GenresController < ApplicationController
  before_action :logged_in_user

  def index
    @genres = Genre.all
  end

  def show
    page = params[:page] || 1
    @genre = Genre.includes(:tracks).find(params[:id])
    @tracks = @genre.tracks.page(page).per(25)
  end

  def create
    if params[:track_id]
      track = Track.find(params[:track_id])
      track.add_genre(strong_params[:name])
      if track.save
        redirect_to edit_admin_track_path(track.sc_id)
      else
        render 'admin/tracks/edit'
      end
    end
  end

  def destroy
    genre = Genre.find(params[:id])
    if genre && params[:track_id]
      track = Track.find(params[:track_id])
      track.delete_genre(params[:id])
      if track.save
        redirect_to edit_admin_track_path(track.sc_id)
      else
        render 'admin/tracks/edit'
      end
    end
  end

  private
  def strong_params
    params.require(:genres).permit(
      :name
    )
  end
end
