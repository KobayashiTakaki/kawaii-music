class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string :sc_id
      t.string :sc_path
      t.string :artist
      t.string :title

      t.timestamps
    end
  end
end
