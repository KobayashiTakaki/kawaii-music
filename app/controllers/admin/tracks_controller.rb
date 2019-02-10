class Admin::TracksController < ApplicationController
  before_action :logged_in_user

  def index
    @tracks = Track.all
  end

  def import
    Track.import(params[:file])
    redirect_to admin_tracks_path, notice: "tracks import done"
  end
end
