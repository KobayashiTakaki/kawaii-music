class Admin::TracksController < ApplicationController
  before_action :logged_in_user

  def index
    @tracks = Track.all
  end

  def edit
    @track = Track.find_by(sc_id: params[:id])
  end

  def update
  end

  def import
    Track.import(params[:file])
    redirect_to admin_tracks_path, notice: "tracks import done"
  end

  private
  def strong_params
    params.require(:track).permit(
      genres_attributes: [:id, :name, :_destroy]
    )
  end
end
