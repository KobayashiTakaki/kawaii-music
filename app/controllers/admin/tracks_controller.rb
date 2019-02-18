class Admin::TracksController < ApplicationController
  before_action :logged_in_user

  def index
    page = params[:page] || 1
    @tracks = query_base.includes(:genres, :categories)
                        .order(:updated_at).page(page).per(25)
  end

  def edit
    @track = Track.find_by(sc_id: params[:id])
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(strong_params)
      respond_to do |format|
        format.html { redirect_to edit_admin_track_path(@track.sc_id) }
        format.js
      end
    else
      render 'admin/tracks/edit'
    end
  end

  def destroy
    Track.find(params[:id]).destroy
    redirect_to admin_tracks_path
  end

  def import
    Track.import(params[:file])
    redirect_to admin_tracks_path, notice: "tracks import done"
  end

  private
  def strong_params
    params.require(:track).permit(
      :description, :comment
    )
  end

  def query_base
    base = Track
    base = base.undescribed if params[:nodescription]
    base = base.nogenre if params[:nogenre]
    base = base.nocategory if params[:nocategory]
    base
  end
end
