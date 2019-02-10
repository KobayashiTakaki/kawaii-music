class AddTracksTagsRelation < ActiveRecord::Migration[5.2]
  def change
    create_table :tags_tracks, id: false do |t|
      t.belongs_to :track, index: true
      t.belongs_to :tag, index: true
    end
  end
end
