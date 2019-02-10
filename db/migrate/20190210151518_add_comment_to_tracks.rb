class AddCommentToTracks < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :comment, :text
  end
end
