class ChangeTagsTracksToCategoriesTracks < ActiveRecord::Migration[5.2]
  def change
    change_table :tags_tracks do |t|
      t.remove_index :tag_id
      t.remove_index :track_id
      t.rename :tag_id, :category_id
      t.index :category_id, name: "index_categories_tracks_on_category_id"
      t.index :track_id, name: "index_categories_tracks_on_track_id"
    end
    rename_table :tags_tracks, :categories_tracks
  end
end
