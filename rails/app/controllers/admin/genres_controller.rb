class Admin::GenresController < ApplicationController
  before_action :logged_in_user

  def index
    @genres = Genre.all.order(:name)
  end

  def show
    page = params[:page] || 1
    @genre = Genre.includes(:tracks).find(params[:id])
    @tracks = @genre.tracks.page(page).per(25)
  end

  def create
    if params[:track_id]
      @track = Track.find(params[:track_id])
      @track.add_genre(strong_params[:name])
      @genre = Genre.find_by(name: strong_params[:name])
      if @track.save
        respond_to do |format|
          format.html { redirect_to edit_admin_track_path(@track.sc_id) }
          format.js
        end
      else
        render 'admin/tracks/edit'
      end
    end
  end

  def destroy
    genre = Genre.find(params[:id])
    if params[:track_id]
      track = Track.find(params[:track_id])
      track.delete_genre(params[:id])
      @genre_id = params[:id]
      if track.save
        respond_to do |format|
          format.html { redirect_to edit_admin_track_path(track.sc_id) }
          format.js
        end
      else
        render 'admin/tracks/edit'
      end
    else
      genre.destroy
      redirect_to admin_genres_path
    end
  end

  private
  def strong_params
    params.require(:genre).permit(
      :name
    )
  end
end
