class AddSequenceToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :sequence, :integer
  end
end
