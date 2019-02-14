class Admin::TagsController < ApplicationController
  before_action :logged_in_user

  def index
    @tags = Tag.all
  end

  def show
    page = params[:page] || 1
    @tag = Tag.includes(:tracks).find(params[:id])
    @tracks = @tag.tracks.page(page).per(25)
  end

  def create
    if params[:track_id]
      @track = Track.find(params[:track_id])
      @track.add_tag(strong_params[:name])
      @tag = Tag.find_by(name: strong_params[:name])
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
    tag = Tag.find(params[:id])
    redirect_to admin_tags_path unless tag
    if params[:track_id]
      track = Track.find(params[:track_id])
      track.delete_tag(params[:id])
      if track.save
        redirect_to edit_admin_track_path(track.sc_id)
      else
        render 'admin/tracks/edit'
      end
    else
      tag.destroy
      redirect_to admin_tags_path
    end
  end

  private
  def strong_params
    params.require(:tag).permit(
      :name
    )
  end
end
