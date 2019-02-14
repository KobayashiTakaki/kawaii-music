class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.text :content
      t.datetime :posted_at

      t.timestamps
    end
  end
end
