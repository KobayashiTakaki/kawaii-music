class Admin::TagsController < ApplicationController
  before_action :logged_in_user

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.includes(:tracks).find(params[:id])
  end

  def create
    if params[:track_id]
      track = Track.find(params[:track_id])
      track.add_tag(strong_params[:name])
      if track.save
        redirect_to edit_admin_track_path(track.sc_id)
      else
        render 'admin/tracks/edit'
      end
    end
  end

  def destroy
    tag = Tag.find(params[:id])
    if tag && params[:track_id]
      track = Track.find(params[:track_id])
      track.delete_tag(params[:id])
      if track.save
        redirect_to edit_admin_track_path(track.sc_id)
      else
        render 'admin/tracks/edit'
      end
    end
  end

  private
  def strong_params
    params.require(:tags).permit(
      :name
    )
  end
end
