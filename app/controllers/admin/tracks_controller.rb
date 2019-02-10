class Admin::TracksController < ApplicationController
  before_action :logged_in_user

  def index
    @tracks = Track.includes(:genres).includes(:tags).all
  end

  def edit
    @track = Track.find_by(sc_id: params[:id])
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(strong_params)
      redirect_to edit_admin_track_path(@track.sc_id)
    else
      render 'admin/tracks/edit'
    end
  end

  def import
    Track.import(params[:file])
    redirect_to admin_tracks_path, notice: "tracks import done"
  end

  private
  def strong_params
    params.require(:track).permit(
      :description
    )
  end
end
