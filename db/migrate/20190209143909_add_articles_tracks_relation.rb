class AddArticlesTracksRelation < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :track, index: true
  end
end
