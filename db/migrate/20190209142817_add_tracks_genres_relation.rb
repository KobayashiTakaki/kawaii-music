class AddTracksGenresRelation < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks_genres, id: false do |t|
      t.belongs_to :track, index: true
      t.belongs_to :genre, index: true
    end
  end
end
