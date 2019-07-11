class AddTweetedAtToTracks < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :tweeted_at, :datetime
  end
end
