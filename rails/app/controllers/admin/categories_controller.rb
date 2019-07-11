class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.all.order(:name)
  end

  def show
    page = params[:page] || 1
    @category = Category.includes(:tracks).find(params[:id])
    @tracks = @category.tracks.page(page).per(25)
  end

  def create
    if params[:track_id]
      @track = Track.find(params[:track_id])
      @track.add_category(strong_params[:name])
      @category = Category.find_by(name: strong_params[:name])
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
    category = Category.find(params[:id])
    if params[:track_id]
      track = Track.find(params[:track_id])
      track.delete_category(params[:id])
      @category_id = params[:id]
      if track.save
        respond_to do |format|
          format.html { redirect_to edit_admin_track_path(track.sc_id) }
          format.js
        end
      else
        render 'admin/tracks/edit'
      end
    else
      category.destroy
      redirect_to admin_categories_path
    end
  end

  private
  def strong_params
    params.require(:category).permit(
      :name
    )
  end
end
