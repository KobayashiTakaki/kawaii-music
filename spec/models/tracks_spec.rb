require "rails_helper"
RSpec.describe "Tracks" do
  let(:genre_house) { create(:genre, name: "house") }
  let(:genre_future_bass) { Genre.create(name: "future bass") }
  let(:category_chill) { create(:category, name: "chill") }
  let(:category_japanese) { create(:category, name: "japanese") }

  context "no tweeted tracks in genre" do
    it "returns tracks in genre by tweet_tracks" do
      tracks = create_list(:track, 3, genres: [genre_house])
      tweet_tracks = Track.tweet_tracks(genre_house, 3)
      tracks.each do |track|
        expect(tweet_tracks).to include(track)
      end
      expect(tweet_tracks.size).to eq(3)
    end
  end

  context "untweeted tracks more than tweet_tracks size in genre" do
    it "returns untweeted tracks tweet_tracks" do
      untweeted_tracks = create_list(:track, 3, genres: [genre_house])
      tweeted_tracks = create_list(:track, 3, tweeted_at: 1.day.ago, genres: [genre_house])
      tweet_tracks = Track.tweet_tracks(genre_house, 3)
      untweeted_tracks.each do |track|
        expect(tweet_tracks).to include(track)
      end
      expect(tweet_tracks.size).to eq(3)
    end
  end

  context "untweeted tracks less than tweet_tracks size in genre" do
    it "returns all untweeted tracks in genre by tweet_tracks" do
      untweeted_tracks = create_list(:track, 2, genres: [genre_house])
      tweeted_tracks = create_list(:track, 3, tweeted_at: 1.day.ago, genres: [genre_house])
      tweet_tracks = Track.tweet_tracks(genre_house, 3)
      untweeted_tracks.each do |track|
        expect(tweet_tracks).to include(track)
      end
      expect(tweet_tracks.size).to eq(3)
      # tweet_tracksからuntweeted_tracksを除いた残りはtweeted_tracksであるはず
      (tweet_tracks-untweeted_tracks).each do |track|
        expect(tweeted_tracks).to include(track)
      end
    end
  end

  it "pick up theme wheighted by track size" do
    # house tracks
    1.times do |i|
      create(:track,
        genres: [genre_house],
        categories: []
      )
    end

    # chill house tracks
    1.times do |i|
      create(:track,
        genres: [genre_house],
        categories: [category_chill]
      )
    end

    # future bass tracks
    10.times do |i|
      create(:track,
        genres: [genre_future_bass],
        categories: []
      )
    end

    # japanese future bass tracks
    10.times do |i|
      create(:track,
        genres: [genre_future_bass],
        categories: [category_japanese]
      )
    end

    count_result = {}
    100.times do
      theme = Track.pick_theme
      if count_result[theme.name]
        count_result[theme.name] += 1
      else
        count_result[theme.name] = 1
      end
    end
    expect(count_result["future bass"]).to be > count_result["house"]
    expect(count_result["japanese"]).to be > count_result["chill"]
  end
end
