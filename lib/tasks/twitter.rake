namespace :twitter do
  desc "post tweets"
  task tweet: :environment do
    tweet = Tweet.not_posted.order_by_seq.limit(1).first
    next if tweet.blank?
    # twitter_client.update(tweet.contet)
    puts tweet.content
    tweet.posted_at = Time.zone.now
    tweet.save!
  end

  task create: :environment do
    seq = 0
    track_tweet_contents.each do |content|
      Tweet.create!(content: content, sequence: seq)
      seq += 1
    end
  end

  def track_tweet_contents
    theme = Track.tweet_theme
    tracks = Track.tweet_tracks(theme, 3)
    contents = []
    contents << "こんばんは。本日は#{theme.name}特集です。"
    tracks.each do |track|
      content = ""
      content += "#{track.artist} - #{track.title}\n"
      content += "#{track.url}\n"
      content += "#{track.description}です。\n" if track.description.present?
      content += "#{track.comment}" if track.comment.present?
      contents << content.strip
    end
    contents
  end

  def twitter_client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CK']
      config.consumer_secret = ENV['TWITTER_CS']
      config.access_token = ENV['TWITTER_AT']
      config.access_token_secret = ENV['TWITTER_ATS']
    end
    client
  end
end
