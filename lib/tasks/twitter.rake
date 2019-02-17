namespace :twitter do
  desc "post tweets"
  task tweet: :environment do
    tweet = Tweet.not_posted.order_by_seq.first
    last_tweet = Tweet.not_posted.order_by_seq.last
    next if tweet.blank?
    if tweet.sequence == 0
      tweet_times = 2
    elsif tweet.sequence == last_tweet.sequence - 1
      tweet_times = 2
    else
      tweet_times = 1
    end

    tweet_times.times do
      tweet = Tweet.not_posted.order_by_seq.first
      break if tweet.blank?
      twitter_client.update(tweet.content)
      tweet.posted_at = Time.zone.now
      tweet.save!
    end

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
    tracks = Track.tweet_tracks(theme, 4)
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
    contents << "本日は以上です。"
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
