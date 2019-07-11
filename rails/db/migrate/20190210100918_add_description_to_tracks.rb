class AddDescriptionToTracks < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :description, :text
  end
end
