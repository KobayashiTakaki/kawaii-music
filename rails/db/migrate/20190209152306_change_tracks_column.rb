class ChangeTracksColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :tracks, :sc_path, :url 
  end
end
