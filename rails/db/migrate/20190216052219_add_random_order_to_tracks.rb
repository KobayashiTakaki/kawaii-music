class AddRandomOrderToTracks < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :random_order, :integer
  end
end
